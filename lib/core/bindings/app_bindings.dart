import 'package:get/get.dart';
import 'package:tractian/core/data/network/api_client_impl.dart';
import 'package:tractian/core/data/network/api_client.dart';

import 'package:tractian/data/repositories/company_repository_impl.dart';

import 'package:tractian/infrastructure/datasource/company_datasource_impl.dart';
import 'package:tractian/shared/domain/datasources/company_datasource.dart';
import 'package:tractian/shared/domain/repositories/company_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiClient>(() => ApiClientImpl());

    Get.lazyPut<CompanyDataSource>(() => CompanyDataSourceImpl(Get.find()));

    Get.lazyPut<CompanyRepository>(() => CompanyRepositoryImpl(Get.find()));
  }
}
