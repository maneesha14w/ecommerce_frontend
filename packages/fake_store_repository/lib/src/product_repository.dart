import 'dart:async';

import 'package:fake_store_api/fake_store_api.dart' hide Product;
import 'package:fake_store_repository/fake_store_repository.dart';

class ProductRepository {
  ProductRepository({FakeStoreApiClient? fakeStoreApiClient})
      : _fakeStoreApiClient = fakeStoreApiClient ?? FakeStoreApiClient();

  final FakeStoreApiClient _fakeStoreApiClient;

  Future<List<Product>> getAllProducts() async {
    final products = await _fakeStoreApiClient.getProducts();
    return products.map((product) {
      return Product(
        id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        image: product.image,
      );
    }).toList();
  }
}
