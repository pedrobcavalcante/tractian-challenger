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

  bool criticalFilter = false;
  bool energyFilter = false;
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
    criticalFilter = value;
    _filterTree();
  }

  void onEnergyFilterButton(bool value) {
    energyFilter = value;
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
    final matchesCritical = !criticalFilter ||
        (node.status == SensorStatus.critico || node.status == null);
    final matchesEnergy = !energyFilter ||
        (node.status == SensorStatus.operacional || node.status == null);
    return matchesName && matchesCritical && matchesEnergy;
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
    List<TreeNode> subLocations = [];
    for (var location in locations) {
      if (location.parentId != null) {
        subLocations.add(TreeNode.fromLocation(location));
      } else {
        tempTreeList.add(TreeNode.fromLocation(location));
      }
    }
    for (var location in subLocations) {
      for (var treeNode in tempTreeList) {
        if (treeNode.id == location.parentId) {
          treeNode.children.add(location);
        }
      }
    }
    for (var treeNode in tempTreeList) {
      for (var asset in assets) {
        if (treeNode.id == asset.locationId || treeNode.id == asset.parentId) {
          treeNode.children.add(TreeNode.fromAsset(asset));
          treeNode.type = ItemType.ativo;
        }
      }
    }
    for (var treeNode in tempTreeList) {
      for (var child in treeNode.children) {
        for (var asset in assets) {
          if (child.id == asset.parentId || child.id == asset.locationId) {
            child.children.add(TreeNode.fromAsset(asset));
            child.type = ItemType.ativo;
          }
        }
      }
    }
    return tempTreeList;
  }
}
