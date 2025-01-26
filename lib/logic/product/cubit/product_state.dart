part of 'product_cubit.dart';

enum ProductListStatus { initial, loading, success, failure }

extension ProductListStatusX on ProductListStatus {
  bool get isInitial => this == ProductListStatus.initial;

  bool get isLoading => this == ProductListStatus.loading;

  bool get isSuccess => this == ProductListStatus.success;

  bool get isFailure => this == ProductListStatus.failure;
}

final class ProductState extends Equatable {
  const ProductState({
    this.status = ProductListStatus.initial,
    List<Product>? products,
  }) : products = products ?? Product.empty;

  final ProductListStatus status;
  final List<Product> products;

  ProductState copyWith({
    ProductListStatus? status,
    List<Product>? products,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [status, products];
}
