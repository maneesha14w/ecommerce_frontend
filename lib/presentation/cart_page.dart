import 'package:ecommerce_frontend/common/constants.dart';
import 'package:ecommerce_frontend/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cart/cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(kCart)),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartItems.isEmpty) {
              return const Center(child: Text(kEmptyCart));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = state.cartItems[index];
                      return Card(
                        child: ListTile(
                          leading: ProductImage(
                            img: product.image,
                            width: 50,
                          ),
                          title: Text(product.title),
                          subtitle: Text('\$${product.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => context
                                .read<CartCubit>()
                                .removeFromCart(product),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                  child: Column(
                    children: [
                      Text(
                        '$kTotal: \$${state.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Checkout Screen
                        },
                        child: const Text(kCheckout),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
