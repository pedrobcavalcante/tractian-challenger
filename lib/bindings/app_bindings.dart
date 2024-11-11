import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../data/datasource/company_datasource.dart';
import '../infrastructure/datasource/company_datasource_impl.dart';
import '../infrastructure/network/api_client.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClient());

    Get.lazyPut<CompanyDataSource>(() => CompanyDataSourceImpl(Get.find()));

    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
