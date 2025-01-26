part of 'cart_cubit.dart';

final class CartState extends Equatable {
  const CartState({
    this.cartItems = const [],
    this.totalPrice = 0.0,
  });

  final List<Product> cartItems;
  final double totalPrice;

  CartState copyWith({
    List<Product>? cartItems,
    double? totalPrice,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  @override
  List<Object> get props => [cartItems, totalPrice];
}
