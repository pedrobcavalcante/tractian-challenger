import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian/infrastructure/datasource/company_datasource_impl.dart';
import 'package:tractian/infrastructure/network/api_client.dart';
import 'package:tractian/utils/errors/exceptions.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late CompanyDataSourceImpl dataSource;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    dataSource = CompanyDataSourceImpl(mockApiClient);
  });

  group('CompanyDataSourceImpl', () {
    const testCompaniesEndpoint = '/companies';
    const testLocationsEndpoint = '/companies/1/locations';
    const testAssetsEndpoint = '/companies/1/assets';
    const mockResponseData = [
      {"id": "1", "name": "Item A"},
      {"id": "2", "name": "Item B"}
    ];

    void mockApiClientResponse(dynamic data) {
      when(() => mockApiClient.get(any())).thenAnswer(
        (_) async => data, // retorna apenas os dados simulados
      );
    }

    group('getCompanies', () {
      test('retorna lista de Company quando a requisição é bem-sucedida',
          () async {
        // Arrange
        mockApiClientResponse(mockResponseData);

        // Act
        final result = await dataSource.getCompanies();

        // Assert
        expect(result, equals(mockResponseData));
        verify(() => mockApiClient.get(testCompaniesEndpoint)).called(1);
      });
    });

    group('getLocations', () {
      test('retorna lista de Location quando a requisição é bem-sucedida',
          () async {
        // Arrange
        mockApiClientResponse(mockResponseData);

        // Act
        final result = await dataSource.getLocations("1");

        // Assert
        expect(result, equals(mockResponseData));
        verify(() => mockApiClient.get(testLocationsEndpoint)).called(1);
      });
    });

    group('getAssets', () {
      test('retorna lista de Asset quando a requisição é bem-sucedida',
          () async {
        // Arrange
        mockApiClientResponse(mockResponseData);

        // Act
        final result = await dataSource.getAssets("1");

        // Assert
        expect(result, equals(mockResponseData));
        verify(() => mockApiClient.get(testAssetsEndpoint)).called(1);
      });
    });

    group('Tratamento de exceções', () {
      test('lança NetworkException ao encontrar SocketException', () async {
        // Arrange
        when(() => mockApiClient.get(any())).thenThrow(SocketException(''));

        // Act & Assert
        expect(
            () => dataSource.getCompanies(), throwsA(isA<NetworkException>()));
      });

      test('lança ServerException ao encontrar FormatException', () async {
        // Arrange
        when(() => mockApiClient.get(any())).thenThrow(FormatException());

        // Act & Assert
        expect(
            () => dataSource.getCompanies(), throwsA(isA<ServerException>()));
      });

      test('lança ServerException para outros erros', () async {
        // Arrange
        when(() => mockApiClient.get(any()))
            .thenThrow(Exception('Erro desconhecido'));

        // Act & Assert
        expect(
            () => dataSource.getCompanies(), throwsA(isA<ServerException>()));
      });
    });
  });
}
