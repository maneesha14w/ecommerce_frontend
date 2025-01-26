import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ecommerce_frontend/logic/product/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(Product product) {
    final updatedCart = List<Product>.from(state.cartItems)..add(product);
    final updatedPrice = state.totalPrice + product.price;

    emit(state.copyWith(
      cartItems: updatedCart,
      totalPrice: updatedPrice,
    ));
  }

  void removeFromCart(Product product) {
    final updatedCart = List<Product>.from(state.cartItems)..remove(product);
    final updatedPrice = state.totalPrice - product.price;

    emit(state.copyWith(
      cartItems: updatedCart,
      totalPrice: updatedPrice,
    ));
  }

  void clearCart() {
    emit(state.copyWith(cartItems: [], totalPrice: 0.0));
  }
}
