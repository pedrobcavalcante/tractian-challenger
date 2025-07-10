import 'package:get/get.dart';
import 'package:tractian/features/asset/domain/entities/asset.dart';
import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/shared/domain/enums/item_type.dart';
import 'package:tractian/shared/domain/enums/sensor_status.dart';
import 'package:tractian/features/asset/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian/features/asset/domain/usecases/get_company_locations_usecase.dart';
import 'package:tractian/features/asset/presentation/localization/asset_translations.dart';

class AssetController extends GetxController {
  final GetCompanyLocationsUseCase getCompanyLocations;
  final GetCompanyAssetsUseCase getCompanyAssets;
  final String companyId;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<TreeNode> filteredTree = <TreeNode>[].obs;
  final RxBool criticalFilter = false.obs;
  final RxBool energyFilter = false.obs;

  final List<TreeNode> _assetTree = <TreeNode>[];
  String _filterValue = '';

  AssetController({
    required this.getCompanyLocations,
    required this.getCompanyAssets,
    required this.companyId,
  });

  @override
  void onInit() {
    super.onInit();
    fetchData();
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
    _filterValue = value.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    if (_assetTree.isEmpty) return;

    filteredTree.value = _filterNodes(_assetTree);
  }

  List<TreeNode> _filterNodes(List<TreeNode> nodes) {
    return nodes.fold<List<TreeNode>>([], (filtered, node) {
      final bool matchesName =
          _filterValue.isEmpty ||
          node.name.toLowerCase().contains(_filterValue);
      final bool matchesCritical =
          !criticalFilter.value || node.status == SensorStatus.critico;
      final bool matchesEnergy =
          !energyFilter.value || node.sensorType == "energy";

      final List<TreeNode> filteredChildren = _filterNodes(node.children);

      final bool nodeMatches = matchesName && matchesCritical && matchesEnergy;
      final bool hasMatchingChildren = filteredChildren.isNotEmpty;

      if (nodeMatches || hasMatchingChildren) {
        final TreeNode filteredNode = TreeNode(
          id: node.id,
          name: node.name,
          type: node.type,
          status: node.status,
          sensorType: node.sensorType,
          children: filteredChildren,
          companyId: node.companyId,
          gatewayId: node.gatewayId,
          locationId: node.locationId,
          sensorId: node.sensorId,
          parentId: node.parentId,
        );
        filtered.add(filteredNode);
      }

      return filtered;
    });
  }

  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final locationsResult = await getCompanyLocations(companyId);
      final assetsResult = await getCompanyAssets(companyId);

      _assetTree.clear();
      _assetTree.addAll(_buildTree(locationsResult, assetsResult));

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
