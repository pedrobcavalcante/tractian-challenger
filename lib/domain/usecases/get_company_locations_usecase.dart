import 'package:tractian/domain/entities/location.dart';
import 'package:tractian/domain/repositories/company_repository.dart';

abstract class GetCompanyLocationsUseCase {
  Future<List<Location>> call(String companyId);
}

class GetCompanyLocationsUseCaseImpl implements GetCompanyLocationsUseCase {
  final CompanyRepository repository;

  GetCompanyLocationsUseCaseImpl(this.repository);

  @override
  Future<List<Location>> call(String companyId) {
    return repository.getCompanyLocations(companyId);
  }
}
