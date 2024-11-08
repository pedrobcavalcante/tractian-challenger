import '../entities/company.dart';
import '../repositories/company_repository.dart';

class GetCompanies {
  final CompanyRepository repository;

  GetCompanies(this.repository);

  Future<List<Company>> execute() {
    return repository.getAllCompanies();
  }
}
