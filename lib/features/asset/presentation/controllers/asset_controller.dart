import 'dart:async';
import 'package:get/get.dart';
import 'package:tractian/core/constants/constants.dart';
import 'package:tractian/features/asset/domain/entities/asset.dart';
import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/shared/domain/enums/item_type.dart';
import 'package:tractian/shared/domain/enums/sensor_status.dart';
import 'package:tractian/features/asset/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian/features/asset/domain/usecases/get_company_locations_usecase.dart';
import 'package:tractian/features/asset/presentation/localization/asset_translations.dart';

import 'package:tractian/features/asset/core/utils/lru_cache.dart';
import 'package:tractian/core/services/isolate_worker_service.dart';
import 'package:tractian/core/services/persistent_cache_service.dart';

class AssetController extends GetxController {
  final GetCompanyLocationsUseCase getCompanyLocations;
  final GetCompanyAssetsUseCase getCompanyAssets;
  final String companyId;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<TreeNode> filteredTree = <TreeNode>[].obs;
  final RxBool criticalFilter = false.obs;
  final RxBool energyFilter = false.obs;
  final RxBool isProcessingFilter = false.obs;

  final List<TreeNode> _assetTree = <TreeNode>[];
  String _filterValue = '';

  late final LRUCache<String, List<TreeNode>> _filterCache;
  late final PersistentCacheService _persistentCache;
  late final IsolateWorkerService _isolateWorker;

  String? _lastCacheKey;
  Timer? _debounceTimer;

  AssetController({
    required this.getCompanyLocations,
    required this.getCompanyAssets,
    required this.companyId,
  }) {
    _filterCache = LRUCache<String, List<TreeNode>>(Constants.maxCacheSize);
    _persistentCache = PersistentCacheService.instance;
    _isolateWorker = IsolateWorkerService.instance;
  }

  @override
  void onInit() {
    super.onInit();
    _persistentCache.initialize();
    fetchData();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void onCriticalFilterButton(bool value) {
    criticalFilter.value = value;
    _applyFilters();
  }

  void onEnergyFilterButton(bool value) {
    energyFilter.value = value;
    _applyFilters();
  }

  void onFilterButton(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      Duration(milliseconds: Constants.debounceDelayMs),
      () {
        _filterValue = value.toLowerCase();
        _applyFilters();
      },
    );
  }

  void _applyFilters() {
    if (_assetTree.isEmpty) return;

    final String cacheKey =
        '${_filterValue}_${criticalFilter.value}_${energyFilter.value}';

    if (_lastCacheKey == cacheKey && _filterCache.containsKey(cacheKey)) {
      final cachedResult = _filterCache.get(cacheKey);
      if (cachedResult != null) {
        filteredTree.value = cachedResult;
        return;
      }
    }

    final persistentResult = _persistentCache.getFilterCache(cacheKey);
    if (persistentResult != null) {
      _filterCache.put(cacheKey, persistentResult);
      _lastCacheKey = cacheKey;
      filteredTree.value = persistentResult;
      return;
    }

    if (_assetTree.length > Constants.maxTreeSizeForSync) {
      _applyFiltersWithIsolate(cacheKey);
    } else {
      final result = _filterNodes(_assetTree);
      _cacheResult(cacheKey, result);
      filteredTree.value = result;
    }
  }

  Future<void> _applyFiltersWithIsolate(String cacheKey) async {
    try {
      isProcessingFilter.value = true;

      final result = await _isolateWorker.processFilters(
        nodes: _assetTree,
        filterValue: _filterValue,
        criticalFilter: criticalFilter.value,
        energyFilter: energyFilter.value,
      );

      _cacheResult(cacheKey, result);
      filteredTree.value = result;
    } catch (e) {
      final result = _filterNodes(_assetTree);
      _cacheResult(cacheKey, result);
      filteredTree.value = result;
    } finally {
      isProcessingFilter.value = false;
    }
  }

  void _cacheResult(String cacheKey, List<TreeNode> result) {
    _filterCache.put(cacheKey, result);
    _persistentCache.putFilterCache(cacheKey, result);
    _lastCacheKey = cacheKey;
  }

  List<TreeNode> _filterNodes(List<TreeNode> nodes) {
    return nodes.fold<List<TreeNode>>([], (filtered, node) {
      final TreeNode? processedNode = _processNodeHierarchically(node);
      if (processedNode != null) {
        filtered.add(processedNode);
      }
      return filtered;
    });
  }

  TreeNode? _processNodeHierarchically(TreeNode node) {
    final bool currentNodeMatches = _nodeMatchesFilters(node);

    if (currentNodeMatches) {
      return _cloneNodeWithAllChildren(node);
    }

    final List<TreeNode> matchingChildren = [];
    for (final child in node.children) {
      final TreeNode? processedChild = _processNodeHierarchically(child);
      if (processedChild != null) {
        matchingChildren.add(processedChild);
      }
    }

    if (matchingChildren.isNotEmpty) {
      return _cloneNodeWithFilteredChildren(node, matchingChildren);
    }

    return null;
  }

  TreeNode _cloneNodeWithAllChildren(TreeNode node) {
    return node.copyWith();
  }

  TreeNode _cloneNodeWithFilteredChildren(
    TreeNode node,
    List<TreeNode> filteredChildren,
  ) {
    return node.copyWith(children: filteredChildren);
  }

  bool _nodeMatchesFilters(TreeNode node) {
    bool matchesTextFilter = true;
    bool matchesCriticalFilter = true;
    bool matchesEnergyFilter = true;

    if (_filterValue.isNotEmpty) {
      matchesTextFilter = node.name.toLowerCase().contains(
        _filterValue.toLowerCase(),
      );
    }

    if (criticalFilter.value) {
      matchesCriticalFilter = node.status == SensorStatus.critico;
    }

    if (energyFilter.value) {
      matchesEnergyFilter = node.sensorType == "energy";
    }

    return matchesTextFilter && matchesCriticalFilter && matchesEnergyFilter;
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final locationsResult = await getCompanyLocations(companyId);
      final assetsResult = await getCompanyAssets(companyId);

      _assetTree.clear();

      if ((locationsResult.length + assetsResult.length) >
          Constants.maxTreeSizeForSync) {
        final treeResult = await _isolateWorker.buildTree(
          locations: locationsResult,
          assets: assetsResult,
        );
        _assetTree.addAll(treeResult);
      } else {
        _assetTree.addAll(_buildTree(locationsResult, assetsResult));
      }

      _applyFilters();
    } catch (e) {
      errorMessage.value = AssetTranslations.errorRetry.tr;
    } finally {
      isLoading.value = false;
    }
  }

  List<TreeNode> _buildTree(List<Location> locations, List<Asset> assets) {
    if (locations.isEmpty && assets.isEmpty) {
      return [];
    }

    final Map<String, TreeNode> nodeMap = <String, TreeNode>{};
    final Set<String> childIds = <String>{};

    for (final location in locations) {
      final TreeNode node = location.toTreeNode();
      nodeMap[node.id] = node;

      if (node.parentId != null) {
        childIds.add(node.id);
      }
    }

    for (final asset in assets) {
      final TreeNode node = asset.toTreeNode();
      nodeMap[node.id] = node;

      final String? parentRef = node.parentId ?? node.locationId;
      if (parentRef != null) {
        childIds.add(node.id);
      }
    }

    for (final node in nodeMap.values) {
      final String? parentId = node.parentId ?? node.locationId;

      if (parentId != null && nodeMap.containsKey(parentId)) {
        final TreeNode parent = nodeMap[parentId]!;
        parent.children.add(node);

        if (parent.type == ItemType.componente &&
            node.type == ItemType.componente) {
          parent.type = ItemType.ativo;
        }
      }
    }

    final List<TreeNode> rootNodes =
        nodeMap.values.where((node) => !childIds.contains(node.id)).toList();

    rootNodes.sort((a, b) => a.name.compareTo(b.name));

    return rootNodes;
  }
}
