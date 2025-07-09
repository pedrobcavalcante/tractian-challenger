import 'package:tractian/domain/entities/company.dart';
import 'package:tractian/domain/repositories/company_repository.dart';

abstract class GetCompaniesUseCase {
  Future<List<Company>> call();
}

class GetCompaniesUseCaseImpl implements GetCompaniesUseCase {
  final CompanyRepository repository;

  GetCompaniesUseCaseImpl(this.repository);
  @override
  Future<List<Company>> call() {
    return repository.getAllCompanies();
  }
}
