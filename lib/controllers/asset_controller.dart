import 'package:get/get.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/asset.dart';
import '../../domain/usecases/get_company_locations.dart';
import '../../domain/usecases/get_company_assets.dart';

class AssetController extends GetxController {
  final GetCompanyLocations getCompanyLocations;
  final GetCompanyAssets getCompanyAssets;

  final RxBool isLoading = true.obs;
  final RxList<Location> locations = <Location>[].obs;
  final RxList<Asset> assets = <Asset>[].obs;

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
    try {
      final locationsResult = await getCompanyLocations(companyId);
      final assetsResult = await getCompanyAssets(companyId);

      locations.assignAll(locationsResult);
      assets.assignAll(assetsResult);
    } catch (e) {
      // Trate o erro
      print('Erro ao buscar dados: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
