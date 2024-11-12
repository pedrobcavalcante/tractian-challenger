import 'package:get/get.dart';
import 'package:tractian/domain/repositories/company_repository.dart';
import '../controllers/asset_controller.dart';
import '../controllers/home_controller.dart';
import '../data/datasource/company_datasource.dart';
import '../data/repositories/company_repository_impl.dart';
import '../domain/usecases/get_company_assets.dart';
import '../domain/usecases/get_company_locations.dart';
import '../domain/usecases/get_companies.dart';
import '../infrastructure/datasource/company_datasource_impl.dart';
import '../infrastructure/network/api_client.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Network
    Get.lazyPut<ApiClient>(() => ApiClient());

    // DataSources
    Get.lazyPut<CompanyDataSource>(() => CompanyDataSourceImpl(Get.find()));

    // Repositories
    Get.lazyPut<CompanyRepository>(() => CompanyRepositoryImpl(Get.find()));

    // Controllers
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
    Get.lazyPut<AssetController>(() => AssetController(
        getCompanyLocations: Get.find(), getCompanyAssets: Get.find()));

    // Use cases
    Get.lazyPut<GetCompanies>(() => GetCompanies(Get.find()));
    Get.lazyPut<GetCompanyAssets>(() => GetCompanyAssets(Get.find()));
    Get.lazyPut<GetCompanyLocations>(() => GetCompanyLocations(Get.find()));
  }
}
