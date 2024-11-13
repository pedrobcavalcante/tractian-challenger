import 'package:get/get.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/asset.dart';
import '../../domain/entities/tree_node.dart';
import '../../domain/usecases/get_company_locations.dart';
import '../../domain/usecases/get_company_assets.dart';
import '../domain/enums/item_type.dart';
import '../domain/enums/sensor_status.dart';

class AssetController extends GetxController {
  final GetCompanyLocations getCompanyLocations;
  final GetCompanyAssets getCompanyAssets;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final List<TreeNode> assetTree = <TreeNode>[];
  final RxList<TreeNode> filteredTree = <TreeNode>[].obs;

  RxBool criticalFilter = false.obs;
  RxBool energyFilter = false.obs;
  String filterValue = '';

  AssetController({
    required this.getCompanyLocations,
    required this.getCompanyAssets,
  });

  @override
  void onInit() {
    super.onInit();
    fetchData(Get.arguments['id']);
  }

  void onCriticalFilterButton(bool value) {
    if (value) {
      energyFilter.value = false;
    }
    criticalFilter.value = value;
    _filterTree();
  }

  void onEnergyFilterButton(bool value) {
    if (value) {
      criticalFilter.value = false;
    }
    energyFilter.value = value;
    _filterTree();
  }

  void onFilterButton(String value) {
    filterValue = value;
    _filterTree();
  }

  void _filterTree() {
    filteredTree.value = _applyFilters(assetTree);
  }

  List<TreeNode> _applyFilters(List<TreeNode> nodes) {
    return nodes
        .map((node) {
          final filteredChildren = _applyFilters(node.children);

          final matches = _matchesFilter(node);

          if (matches || filteredChildren.isNotEmpty) {
            return TreeNode(
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
          }

          return null;
        })
        .whereType<TreeNode>()
        .toList();
  }

  bool _matchesFilter(TreeNode node) {
    final matchesName =
        node.name.toLowerCase().contains(filterValue.toLowerCase());

    final matchesCritical = node.type != ItemType.componente ||
        !criticalFilter.value ||
        node.status == SensorStatus.critico;

    final matchesEnergy = node.type != ItemType.componente ||
        !energyFilter.value ||
        node.status == SensorStatus.operacional;

    return matchesName || (matchesCritical && matchesEnergy);
  }

  Future<void> fetchData(String companyId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final locationsResult = await getCompanyLocations(companyId);
      final assetsResult = await getCompanyAssets(companyId);

      final organizedTree = _buildTree(locationsResult, assetsResult);
      assetTree.assignAll(organizedTree);
      filteredTree.assignAll(organizedTree);
    } catch (e) {
      errorMessage.value = 'Erro ao buscar dados: $e';
    } finally {
      isLoading.value = false;
    }
  }

  List<TreeNode> _buildTree(List<Location> locations, List<Asset> assets) {
    List<TreeNode> tempTreeList = [];
    _addLocations(locations, tempTreeList);
    List<TreeNode> assetTreeList =
        assets.map((asset) => TreeNode.fromAsset(asset)).toList();
    _addAssets(assetTreeList, tempTreeList);

    return tempTreeList;
  }

  void _addAssets(List<Asset> assets, List<TreeNode> treeList) {
    for (final tempTree in treeList) {
      for (final asset in assets) {
        if (tempTree.id == asset.locationId || tempTree.id == asset.parentId) {
          tempTree.children.add(TreeNode.fromAsset(asset));
          if (tempTree.type == ItemType.componente) {
            tempTree.type = ItemType.ativo;
          }
        }
      }
      if (tempTree.children.isNotEmpty) {
        _addAssets(assets, tempTree.children);
      }
    }
  }

  void _addLocations(List<Location> locations, List<TreeNode> treeList) {
    List<TreeNode> subLocations = [];
    for (var location in locations) {
      if (location.parentId != null) {
        subLocations.add(TreeNode.fromLocation(location));
      } else {
        treeList.add(TreeNode.fromLocation(location));
      }
    }
    for (var location in subLocations) {
      for (var treeNode in treeList) {
        if (treeNode.id == location.parentId) {
          treeNode.children.add(location);
        }
      }
    }
  }
}
