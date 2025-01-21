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

    test('throws ProductsNotFoundFailure on empty response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn('[]');
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      expect(
        () async => apiClient.getProducts(),
        throwsA(isA<ProductsNotFoundFailure>()),
      );
    });

    test('returns List<Products> on valid response', () async {
      final response = MockResponse();
      when(() => response.statusCode).thenReturn(200);
      when(() => response.body).thenReturn(
        '''
[
  {
    "id": 1,
    "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
    "price": 109.95,
    "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday.",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
    "rating": {
      "rate": 3.9,
      "count": 120
    }
  },
  {
    "id": 2,
    "title": "Mens Casual Premium Slim Fit T-Shirts",
    "price": 22.3,
    "description": "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, lightweight & soft fabric for breathable and comfortable wearing. Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
    "category": "men's clothing",
    "image": "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
    "rating": {
      "rate": 4.1,
      "count": 259
    }
  }
]
 ''',
      );
      when(() => httpClient.get(any())).thenAnswer((_) async => response);
      final actual = await apiClient.getProducts();
      expect(
        actual,
        isA<List<Product>>()
            .having((p) => p[0].price, 'price', 109.95)
            .having((p) => p[1].price, 'price', 22.3),
      );
    });
  });
}
