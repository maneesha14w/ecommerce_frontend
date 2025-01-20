// ignore_for_file: prefer_const_constructors
import 'package:fake_store_api/fake_store_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('FakeStoreApiClient', () {
    late http.Client httpClient;
    late FakeStoreApiClient apiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      apiClient = FakeStoreApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(FakeStoreApiClient(), isNotNull);
      });
    });

    group('getProducts', () {
      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await apiClient.getProducts();
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https('fakestoreapi.com', '/products'),
          ),
        ).called(1);
      });
    });

    test('throws ProductsRequestFailure on non-200 response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(400);
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      expect(
        () async => apiClient.getProducts(),
        throwsA(isA<ProductRequestFailure>()),
      );
    });
  });
}
