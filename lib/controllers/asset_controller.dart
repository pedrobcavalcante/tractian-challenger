import 'package:get/get.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/asset.dart';
import '../../domain/entities/tree_node.dart';
import '../../domain/usecases/get_company_locations.dart';
import '../../domain/usecases/get_company_assets.dart';
import '../domain/enums/item_type.dart';

class AssetController extends GetxController {
  final GetCompanyLocations getCompanyLocations;
  final GetCompanyAssets getCompanyAssets;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxList<TreeNode> assetTree = <TreeNode>[].obs;

  AssetController({
    required this.getCompanyLocations,
    required this.getCompanyAssets,
  });

  @override
  void onInit() {
    super.onInit();
    fetchData(Get.arguments['id']);
  }

  Future<void> fetchData(String companyId) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Busca locations e assets
      final locationsResult = await getCompanyLocations(companyId);
      final assetsResult = await getCompanyAssets(companyId);

      // Constrói a árvore de locations e assets
      final organizedTree = _buildTree(locationsResult, assetsResult);
      assetTree.assignAll(organizedTree);
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
