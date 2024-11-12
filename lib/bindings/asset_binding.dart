import 'package:get/get.dart';
import '../controllers/asset_controller.dart';
import '../domain/usecases/get_company_assets.dart';
import '../domain/usecases/get_company_locations.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    // Use Cases
    Get.lazyPut<GetCompanyAssets>(() => GetCompanyAssets(Get.find()));
    Get.lazyPut<GetCompanyLocations>(() => GetCompanyLocations(Get.find()));

    // Controlador
    Get.lazyPut<AssetController>(() => AssetController(
          getCompanyLocations: Get.find(),
          getCompanyAssets: Get.find(),
        ));
  }
}
