import 'package:get/get.dart';
import 'package:tractian/controllers/asset_controller.dart';
import 'package:tractian/domain/usecases/get_company_assets.dart';
import 'package:tractian/domain/usecases/get_company_locations.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCompanyAssets>(() => GetCompanyAssets(Get.find()));
    Get.lazyPut<GetCompanyLocations>(() => GetCompanyLocations(Get.find()));

    Get.lazyPut<AssetController>(
      () => AssetController(
        getCompanyLocations: Get.find(),
        getCompanyAssets: Get.find(),
      ),
    );
  }
}
