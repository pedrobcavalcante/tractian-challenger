import 'package:get/get.dart';

import '../../data/datasource/company_datasource.dart';
import '../../utils/errors/exceptions.dart';

class HomeController extends GetxController {
  final CompanyDataSource dataSource;

  var units = <String>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  HomeController(this.dataSource);

  @override
  void onInit() {
    super.onInit();
    fetchUnits();
  }

  void fetchUnits() async {
    try {
      isLoading(true);
      final fetchedUnits = await dataSource.getCompanies();
      units.value = fetchedUnits.map((unit) => unit['name'] as String).toList();
    } on ServerException catch (e) {
      errorMessage(e.message);
    } catch (e) {
      errorMessage('Erro desconhecido: $e');
    } finally {
      isLoading(false);
    }
  }
}
