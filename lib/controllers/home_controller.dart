import 'package:get/get.dart';

import '../../utils/errors/exceptions.dart';

import '../../domain/usecases/get_companies.dart';
import '../domain/entities/company.dart';

class HomeController extends GetxController {
  final GetCompanies getCompaniesUseCase;

  var units = <Company>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  HomeController(this.getCompaniesUseCase);

  @override
  void onInit() {
    super.onInit();
    fetchUnits();
  }

  void fetchUnits() async {
    try {
      isLoading(true);
      units.value = await getCompaniesUseCase();
    } on ServerException catch (e) {
      errorMessage(e.message);
    } catch (e) {
      errorMessage('Erro desconhecido: $e');
    } finally {
      isLoading(false);
    }
  }
}
