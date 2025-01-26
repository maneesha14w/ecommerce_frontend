import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../product/models/product.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(const CheckoutState());

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void initializeCart(List<Product> cartItems, double totalPrice) {
    emit(state.copyWith(cartItems: cartItems, totalPrice: totalPrice));
  }

  Future<void> placeOrder() async {
    if (state.name.isEmpty ||
        state.address.isEmpty ||
        state.phoneNumber.isEmpty) {
      emit(state.copyWith(
        status: CheckoutStatus.failure,
        errorMessage: 'All fields are required.',
      ));
      return;
    }

    try {
      emit(state.copyWith(status: CheckoutStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(status: CheckoutStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: CheckoutStatus.failure,
        errorMessage: 'Failed to place the order.',
      ));
    }
  }
}
