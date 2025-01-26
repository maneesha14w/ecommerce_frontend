import 'package:ecommerce_frontend/logic/product/cubit/product_cubit.dart';
import 'package:ecommerce_frontend/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store_repository/fake_store_repository.dart';

import 'logic/cart/cubit/cart_cubit.dart';

void main() {
  final productRepository = ProductRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => ProductCubit(productRepository),
      ),
      BlocProvider(
        create: (_) => CartCubit(),
      ),
    ],
    child: MyApp(productRepository: productRepository),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.productRepository});

  final ProductRepository productRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
