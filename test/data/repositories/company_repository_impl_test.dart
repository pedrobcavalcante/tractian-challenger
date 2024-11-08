import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian/data/datasource/company_datasource.dart';
import 'package:tractian/data/repositories/company_repository_impl.dart';
import 'package:tractian/domain/entities/asset.dart';
import 'package:tractian/domain/entities/company.dart';
import 'package:tractian/domain/entities/location.dart';

class MockCompanyDataSource extends Mock implements CompanyDataSource {}

void main() {
  late CompanyRepositoryImpl repository;
  late MockCompanyDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCompanyDataSource();
    repository = CompanyRepositoryImpl(mockDataSource);
  });

  group('CompanyRepositoryImpl', () {
    group('getAllCompanies', () {
      test(
          'deve retornar uma lista de Company quando o DataSource retorna sucesso',
          () async {
        // Arrange
        final companyJson = [
          {"id": "1", "name": "Company A"},
          {"id": "2", "name": "Company B"}
        ];
        when(() => mockDataSource.getCompanies())
            .thenAnswer((_) async => companyJson);

        // Act
        final result = await repository.getAllCompanies();

        // Assert
        expect(result, isA<List<Company>>());
        expect(result.length, 2);
        expect(result[0].name, "Company A");
        expect(result[1].name, "Company B");
        verify(() => mockDataSource.getCompanies()).called(1);
      });

      test('deve lançar uma exceção se o DataSource falhar', () async {
        // Arrange
        when(() => mockDataSource.getCompanies())
            .thenThrow(Exception("Erro ao carregar empresas"));

        // Act & Assert
        expect(() => repository.getAllCompanies(), throwsException);
        verify(() => mockDataSource.getCompanies()).called(1);
      });
    });

    group('getCompanyLocations', () {
      test(
          'deve retornar uma lista de Location quando o DataSource retorna sucesso',
          () async {
        // Arrange
        final locationJson = [
          {"id": "1", "name": "Location A", "companyId": "1"},
          {"id": "2", "name": "Location B", "companyId": "1"}
        ];
        when(() => mockDataSource.getLocations("1"))
            .thenAnswer((_) async => locationJson);

        // Act
        final result = await repository.getCompanyLocations("1");

        // Assert
        expect(result, isA<List<Location>>());
        expect(result.length, 2);
        expect(result[0].name, "Location A");
        expect(result[1].name, "Location B");
        verify(() => mockDataSource.getLocations("1")).called(1);
      });

      test('deve lançar uma exceção se o DataSource falhar', () async {
        // Arrange
        when(() => mockDataSource.getLocations("1"))
            .thenThrow(Exception("Erro ao carregar locais"));

        // Act & Assert
        expect(() => repository.getCompanyLocations("1"), throwsException);
        verify(() => mockDataSource.getLocations("1")).called(1);
      });
    });

    group('getCompanyAssets', () {
      test(
          'deve retornar uma lista de Asset quando o DataSource retorna sucesso',
          () async {
        // Arrange
        final assetJson = [
          {"id": "1", "name": "Asset A", "companyId": "1"},
          {"id": "2", "name": "Asset B", "companyId": "1"}
        ];
        when(() => mockDataSource.getAssets("1"))
            .thenAnswer((_) async => assetJson);

        // Act
        final result = await repository.getCompanyAssets("1");

        // Assert
        expect(result, isA<List<Asset>>());
        expect(result.length, 2);
        expect(result[0].name, "Asset A");
        expect(result[1].name, "Asset B");
        verify(() => mockDataSource.getAssets("1")).called(1);
      });

      test('deve lançar uma exceção se o DataSource falhar', () async {
        // Arrange
        when(() => mockDataSource.getAssets("1"))
            .thenThrow(Exception("Erro ao carregar ativos"));

        // Act & Assert
        expect(() => repository.getCompanyAssets("1"), throwsException);
        verify(() => mockDataSource.getAssets("1")).called(1);
      });
    });
  });
}
