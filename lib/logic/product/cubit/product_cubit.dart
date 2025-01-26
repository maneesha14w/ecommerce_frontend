import 'package:bloc/bloc.dart';
import 'package:fake_store_repository/fake_store_repository.dart'
    show ProductRepository;
import 'package:equatable/equatable.dart';
import '../models/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepository) : super(ProductState());

  final ProductRepository _productRepository;

  Future<void> fetchProducts() async {
    emit(state.copyWith(status: ProductListStatus.loading));
    try {
      final products = Product.fromRepository(
        await _productRepository.getAllProducts(),
      );
      emit(
        state.copyWith(
          status: ProductListStatus.success,
          products: products,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ProductListStatus.failure));
    }
  }
}
