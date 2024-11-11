import 'dart:io';

import 'package:dio/dio.dart';
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

    void mockApiClientResponse(int statusCode, dynamic data) {
      when(() => mockApiClient.get(any())).thenAnswer(
        (_) async => Response(
          statusCode: statusCode,
          data: data,
          requestOptions: RequestOptions(path: ''),
        ),
      );
    }

    group('getCompanies', () {
      test('retorna lista de Company ao receber status 200', () async {
        // Arrange
        mockApiClientResponse(200, mockResponseData);

        // Act
        final result = await dataSource.getCompanies();

        // Assert
        expect(result, equals(mockResponseData));
        verify(() => mockApiClient.get(testCompaniesEndpoint)).called(1);
      });

      test('lança UnauthorizedException para status 401', () async {
        // Arrange
        mockApiClientResponse(401, null);

        // Act & Assert
        expect(() async => await dataSource.getCompanies(),
            throwsA(isA<UnauthorizedException>()));
        verify(() => mockApiClient.get(testCompaniesEndpoint)).called(1);
      });

      test('lança NotFoundException para status 404', () async {
        // Arrange
        mockApiClientResponse(404, null);

        // Act & Assert
        expect(
            () => dataSource.getCompanies(), throwsA(isA<NotFoundException>()));
        verify(() => mockApiClient.get(testCompaniesEndpoint)).called(1);
      });

      test('lança ServerException para status 500', () async {
        // Arrange
        mockApiClientResponse(500, null);

        // Act & Assert
        expect(
            () => dataSource.getCompanies(), throwsA(isA<ServerException>()));
        verify(() => mockApiClient.get(testCompaniesEndpoint)).called(1);
      });
    });

    group('getLocations', () {
      test('retorna lista de Location ao receber status 200', () async {
        // Arrange
        mockApiClientResponse(200, mockResponseData);

        // Act
        final result = await dataSource.getLocations("1");

        // Assert
        expect(result, equals(mockResponseData));
        verify(() => mockApiClient.get(testLocationsEndpoint)).called(1);
      });

      test('lança UnauthorizedException para status 401', () async {
        // Arrange
        mockApiClientResponse(401, null);

        // Act & Assert
        expect(() => dataSource.getLocations("1"),
            throwsA(isA<UnauthorizedException>()));
        verify(() => mockApiClient.get(testLocationsEndpoint)).called(1);
      });
    });

    group('getAssets', () {
      test('retorna lista de Asset ao receber status 200', () async {
        // Arrange
        mockApiClientResponse(200, mockResponseData);

        // Act
        final result = await dataSource.getAssets("1");

        // Assert
        expect(result, equals(mockResponseData));
        verify(() => mockApiClient.get(testAssetsEndpoint)).called(1);
      });

      test('lança ServerException para erro desconhecido', () async {
        // Arrange
        mockApiClientResponse(418, null); // Status de erro não mapeado

        // Act & Assert
        expect(
            () => dataSource.getAssets("1"), throwsA(isA<ServerException>()));
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
