import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text(product.category),
                trailing: Text('\$${product.price}'),
              );
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text('Failed to fetch products: ${state.message}'));
        } else if (state is ProductCreated) {
          return Center(child: Text('Product Created: ${state.product.name}'));
        }
        return const Center(child: Text('No products available.'));
      },
    );
  }
}
