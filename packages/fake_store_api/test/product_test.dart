import 'package:fake_store_api/fake_store_api.dart';
import 'package:test/test.dart';

void main() {
  group('Product', () {
    group('fromJson', () {
      test('returns correct Product object', () {
        expect(
          Product.fromJson(<String, dynamic>{
            "id": 1,
            "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            "price": 109.95,
            "description":
                "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            "category": "men's clothing",
            "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            "rating": {"rate": 3.9, "count": 120},
          }),
          isA<Product>()
              .having((p) => p.price, 'price', 109.95)
              .having((p) => p.rating.rate, 'rating rate', 3.9)
              .having((p) => p.rating.count, 'rating count', 120),
        );
      });
    });
  });
}
