import 'package:tractian/domain/entities/asset.dart';
import 'package:tractian/shared/domain/repositories/company_repository.dart';

abstract class GetCompanyAssetsUseCase {
  Future<List<Asset>> call(String companyId);
}

class GetCompanyAssetsUseCaseImpl implements GetCompanyAssetsUseCase {
  final CompanyRepository repository;

  GetCompanyAssetsUseCaseImpl(this.repository);

  @override
  Future<List<Asset>> call(String companyId) {
    return repository.getCompanyAssets(companyId);
  }
}
