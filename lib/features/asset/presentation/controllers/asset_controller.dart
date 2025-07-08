import 'package:get/get.dart';
import 'package:tractian/domain/entities/asset.dart';
import 'package:tractian/domain/entities/location.dart';
import 'package:tractian/domain/entities/tree_node.dart';
import 'package:tractian/domain/enums/item_type.dart';
import 'package:tractian/domain/enums/sensor_status.dart';
import 'package:tractian/domain/mapper/tree_node_mapper.dart';
import 'package:tractian/domain/usecases/get_company_assets.dart';
import 'package:tractian/domain/usecases/get_company_locations.dart';

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
    criticalFilter.value = value;
    _filterTree();
  }

  void onEnergyFilterButton(bool value) {
    energyFilter.value = value;
    _filterTree();
  }

  void onFilterButton(String value) {
    filterValue = value;
    _filterTree();
  }

  void _filterTree() {
    filteredTree.value = _applyMatches(assetTree);
    filteredTree.value = _applyFilter(filteredTree);
  }

  List<TreeNode> _applyFilter(List<TreeNode> nodes) {
    return nodes
        .map((node) {
          final matches = node.name.toLowerCase().contains(
            filterValue.toLowerCase(),
          );

          if (matches) {
            return node;
          } else {
            final filteredChildren = _applyFilter(node.children);
            if (filteredChildren.isNotEmpty) {
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
          }

          return null;
        })
        .whereType<TreeNode>()
        .toList();
  }

  List<TreeNode> _applyMatches(List<TreeNode> nodes) {
    return nodes
        .map((node) {
          final filteredChildren = _applyMatches(node.children);

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
    final matchesCritical =
        !criticalFilter.value || node.status == SensorStatus.critico;

    final matchesEnergy = !energyFilter.value || node.sensorType == "energy";

    return matchesCritical && matchesEnergy;
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
    final locationsTree =
        locations
            .map((location) => TreeNodeMapper.fromLocation(location))
            .toList();
    List<TreeNode> tempTreeList = _addBase(locationsTree);
    final assetNodes =
        assets.map((asset) => TreeNodeMapper.fromAsset(asset)).toList();
    _addAssets(assetNodes + locationsTree, tempTreeList);

    return tempTreeList;
  }

  void _addAssets(List<TreeNode> assets, List<TreeNode> treeList) {
    for (final treeNode in treeList) {
      for (final asset in assets) {
        if (treeNode.id == asset.locationId || treeNode.id == asset.parentId) {
          treeNode.children.add(asset);
          if (treeNode.type == ItemType.componente) {
            treeNode.type = ItemType.ativo;
          }
        }
      }
      if (treeNode.children.isNotEmpty) {
        _addAssets(assets, treeNode.children);
      }
    }
  }

  List<TreeNode> _addBase(List<TreeNode> allNodes) {
    return allNodes
        .where((node) => node.parentId == null && node.locationId == null)
        .map((node) => TreeNodeMapper.fromLocation(node))
        .toList();
  }
}
