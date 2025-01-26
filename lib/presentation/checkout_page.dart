import 'package:ecommerce_frontend/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/constants.dart';
import '../logic/checkout/cubit/checkout_cubit.dart';
import '../logic/product/models/product.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  final List<Product> cartItems;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckoutCubit()..initializeCart(cartItems, totalPrice),
      child: const CheckoutView(),
    );
  }
}

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kCheckout),
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listener: (context, state) {
          if (state.status == CheckoutStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(kOrderSuccess)),
            );

            Navigator.pop(context);
          } else if (state.status == CheckoutStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: BlocBuilder<CheckoutCubit, CheckoutState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      kShippingInfo,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: kFullName),
                      onChanged: (value) =>
                          context.read<CheckoutCubit>().updateName(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return kEnterName;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: kAddress),
                      onChanged: (value) =>
                          context.read<CheckoutCubit>().updateAddress(value),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return kEnterAddress;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: kPhoneNum),
                      onChanged: (value) => context
                          .read<CheckoutCubit>()
                          .updatePhoneNumber(value),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return kEnterPhoneNum;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      kOrderSummary,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...state.cartItems.map((product) => ListTile(
                          leading: ProductImage(img: product.image, width: 50),
                          title: Text(product.title),
                          subtitle:
                              Text('\$${product.price.toStringAsFixed(2)}'),
                        )),
                    const Divider(),
                    Text(
                      '\$${state.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<CheckoutCubit>().placeOrder(context);
                        }
                      },
                      child: const Text(kPlaceOrder),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
