import 'dart:convert';

import 'package:fake_store_api/fake_store_api.dart';
import 'package:http/http.dart' as http;

/// Exception thrown when getProducts fails.
class ProductRequestFailure implements Exception {}

//
class ProductsNotFoundFailure implements Exception {}

/// {@template fake_store_api_client}
/// Dart API Client which wraps the [Fake Store Api](https://fakestoreapi.com/).
/// {@endtemplate}
class FakeStoreApiClient {
  /// {@macro fake_store_api_client}
  FakeStoreApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'fakestoreapi.com';

  final http.Client _httpClient;

  /// Fetches [Products].
  Future<List<Product>> getProducts() async {
    final productsRequest = Uri.https(_baseUrl, '/products');

    final productResponse = await _httpClient.get(productsRequest);

    if (productResponse.statusCode != 200) {
      throw ProductRequestFailure();
    }

    final bodyJson = jsonDecode(productResponse.body) as List<dynamic>;

    if (bodyJson.isEmpty) {
      throw ProductsNotFoundFailure();
    }

    return bodyJson.map((json) => Product.fromJson(json)).toList();
  }
}
