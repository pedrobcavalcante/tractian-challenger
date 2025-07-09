import 'package:get/get.dart';
import 'package:tractian/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian/domain/usecases/get_company_locations_usecase.dart';
import 'package:tractian/features/asset/presentation/controllers/asset_controller.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCompanyAssetsUseCase>(
      () => GetCompanyAssetsUseCaseImpl(Get.find()),
    );
    Get.lazyPut<GetCompanyLocationsUseCase>(
      () => GetCompanyLocationsUseCaseImpl(Get.find()),
    );

    final companyId = Get.arguments['id'] as String;
    Get.lazyPut<AssetController>(
      () => AssetController(
        getCompanyLocations: Get.find(),
        getCompanyAssets: Get.find(),
        companyId: companyId,
      ),
    );
  }
}
