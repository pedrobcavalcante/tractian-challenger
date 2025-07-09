import 'package:tractian/features/asset/domain/entities/company.dart';

import 'package:tractian/shared/domain/repositories/company_repository.dart';

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
