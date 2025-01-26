import 'package:fake_store_api/fake_store_api.dart' as api;
import 'package:fake_store_repository/fake_store_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockFakeStoreApiClient extends Mock implements api.FakeStoreApiClient {}

void main() {
  group('ProductRepository', () {
    late api.FakeStoreApiClient fakeStoreApiClient;
    late ProductRepository productRepository;

    setUp(() {
      fakeStoreApiClient = MockFakeStoreApiClient();
      productRepository =
          ProductRepository(fakeStoreApiClient: fakeStoreApiClient);
    });

    group('constructor', () {
      test('can be instantiated without an explicit client', () {
        expect(ProductRepository(), isNotNull);
      });
    });

    group('getAllProducts', () {
      test('calls getProducts on the FakeStoreApiClient', () async {
        final mockProducts = [
          api.Product(
            id: 1,
            title: 'Product 1',
            price: 19.99,
            description: 'Description 1',
            category: 'Category 1',
            image: 'https://example.com/image1.jpg',
            rating: api.Rating(rate: 4.5, count: 10),
          ),
          api.Product(
            id: 2,
            title: 'Product 2',
            price: 29.99,
            description: 'Description 2',
            category: 'Category 2',
            image: 'https://example.com/image2.jpg',
            rating: api.Rating(rate: 3.9, count: 20),
          ),
        ];

        when(() => fakeStoreApiClient.getProducts())
            .thenAnswer((_) async => mockProducts);

        final products = await productRepository.getAllProducts();

        verify(() => fakeStoreApiClient.getProducts()).called(1);
        expect(products, hasLength(2));
        expect(
          products.first,
          isA<Product>()
              .having((p) => p.id, 'id', 1)
              .having((p) => p.title, 'title', 'Product 1')
              .having((p) => p.price, 'price', 19.99),
        );
      });
    });

    test('returns an empty list when no products are returned', () async {
      when(() => fakeStoreApiClient.getProducts()).thenAnswer((_) async => []);

      final products = await productRepository.getAllProducts();

      verify(() => fakeStoreApiClient.getProducts()).called(1);
      expect(products, isEmpty);
    });
  });
}
