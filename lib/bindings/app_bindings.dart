import 'package:get/get.dart';
import 'package:tractian/domain/repositories/company_repository.dart';
import '../data/datasource/company_datasource.dart';
import '../data/repositories/company_repository_impl.dart';
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
  }
}
