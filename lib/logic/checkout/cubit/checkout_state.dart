part of 'checkout_cubit.dart';

enum CheckoutStatus { initial, loading, success, failure }

final class CheckoutState extends Equatable {
  const CheckoutState({
    this.status = CheckoutStatus.initial,
    this.name = '',
    this.address = '',
    this.phoneNumber = '',
    this.cartItems = const [],
    this.totalPrice = 0.0,
    this.errorMessage = '',
  });

  final CheckoutStatus status;
  final String name;
  final String address;
  final String phoneNumber;
  final List<Product> cartItems;
  final double totalPrice;
  final String errorMessage;

  CheckoutState copyWith({
    CheckoutStatus? status,
    String? name,
    String? address,
    String? phoneNumber,
    List<Product>? cartItems,
    double? totalPrice,
    String? errorMessage,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, name, address, phoneNumber, cartItems, totalPrice, errorMessage];
}
