import 'package:get/get.dart';
import 'package:tractian/features/asset/domain/entities/asset.dart';
import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/domain/enums/item_type.dart';
import 'package:tractian/domain/enums/sensor_status.dart';
import 'package:tractian/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian/features/asset/presentation/localization/asset_translations.dart';

class AssetController extends GetxController {
  final GetCompanyAssetsUseCase getCompanyLocations;
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
      // Verifica se o nó atual passa pelos filtros
      final bool matchesName =
          _filterValue.isEmpty ||
          node.name.toLowerCase().contains(_filterValue);
      final bool matchesCritical =
          !criticalFilter.value || node.status == SensorStatus.critico;
      final bool matchesEnergy =
          !energyFilter.value || node.sensorType == "energy";

      // Filtra os filhos recursivamente
      final List<TreeNode> filteredChildren = _filterNodes(node.children);

      // Se o nó atual passa pelos filtros ou tem filhos que passam
      if ((matchesName && matchesCritical && matchesEnergy) ||
          filteredChildren.isNotEmpty) {
        // Cria uma cópia do nó com os filhos filtrados
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
    // Converte locations para TreeNodes
    final List<TreeNode> locationsTree =
        locations.map((location) => location.toTreeNode()).toList();

    // Filtra apenas nós base (sem parent)
    final List<TreeNode> baseNodes =
        locationsTree
            .where((node) => node.parentId == null && node.locationId == null)
            .toList();

    // Converte assets para TreeNodes
    final List<TreeNode> assetNodes =
        assets.map((asset) => asset.toTreeNode()).toList();

    // Adiciona assets aos seus respectivos parents
    _attachAssetsToParents([...assetNodes, ...locationsTree], baseNodes);

    return baseNodes;
  }

  void _attachAssetsToParents(
    List<TreeNode> assets,
    List<TreeNode> parentNodes,
  ) {
    for (final parent in parentNodes) {
      final List<TreeNode> children =
          assets
              .where(
                (asset) =>
                    asset.locationId == parent.id ||
                    asset.parentId == parent.id,
              )
              .toList();

      if (children.isNotEmpty) {
        parent.children.addAll(children);
        if (parent.type == ItemType.componente) {
          parent.type = ItemType.ativo;
        }

        // Continua a recursão com os novos filhos
        _attachAssetsToParents(assets, children);
      }
    }
  }
}
