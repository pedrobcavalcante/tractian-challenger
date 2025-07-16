import 'package:get/get.dart';
import 'package:tractian/features/asset/domain/usecases/get_company_assets_usecase.dart';
import 'package:tractian/features/asset/domain/usecases/get_company_locations_usecase.dart';
import 'package:tractian/features/asset/presentation/controllers/asset_controller.dart';
import 'package:tractian/core/services/persistent_cache_service.dart';
import 'package:tractian/core/services/isolate_worker_service.dart';
import 'package:tractian/features/asset/core/utils/lru_cache.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/core/constants/constants.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetCompanyAssetsUseCase>(
      () => GetCompanyAssetsUseCaseImpl(Get.find()),
    );
    Get.lazyPut<GetCompanyLocationsUseCase>(
      () => GetCompanyLocationsUseCaseImpl(Get.find()),
    );

    Get.lazyPut<PersistentCacheService>(() => PersistentCacheService());
    Get.lazyPut<IsolateWorkerService>(() => IsolateWorkerService());
    Get.lazyPut<LRUCache<String, List<TreeNode>>>(
      () => LRUCache<String, List<TreeNode>>(Constants.maxCacheSize),
    );

    final companyId = Get.arguments['id'] as String;
    Get.lazyPut<AssetController>(
      () => AssetController(
        getCompanyLocations: Get.find(),
        getCompanyAssets: Get.find(),
        persistentCache: Get.find(),
        isolateWorker: Get.find(),
        filterCache: Get.find(),
        companyId: companyId,
      ),
    );
  }
}
