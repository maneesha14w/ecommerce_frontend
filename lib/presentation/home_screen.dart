import 'package:ecommerce_frontend/common/constants.dart';
import 'package:ecommerce_frontend/logic/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_frontend/presentation/cart_page.dart';
import 'package:ecommerce_frontend/presentation/product_details.dart';
import 'package:ecommerce_frontend/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/product/cubit/product_cubit.dart';
import '../logic/product/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    final allProducts = context.read<ProductCubit>().state.products;

    setState(() {
      _filteredProducts = allProducts
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text(kTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status.isSuccess) {
              final products = isSearching ? _filteredProducts : state.products;

              if (products.isEmpty) {
                return const Center(child: Text('No products found'));
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(product: product);
                  },
                ),
              );
            } else if (state.status.isFailure) {
              return Center(
                child: Text(
                  'Error: ${state.status}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: ProductImage(img: product.image)),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          WidgetStatePropertyAll<Color>(Colors.white),
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.blue)),
                  onPressed: () {
                    context.read<CartCubit>().addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.title} added to cart!'),
                      ),
                    );
                  },
                  child: Text(kAddToCart)),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
