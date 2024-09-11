import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../widgets/product_view.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Mories Deo Technical Test'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => ProductBloc()..add(FetchProducts(1)),
          child: const ProductView(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController stockController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: stockController,
                  decoration: const InputDecoration(labelText: 'Stock'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final product = Product(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  price: int.tryParse(priceController.text) ?? 0,
                  category: categoryController.text,
                  description: descriptionController.text,
                  stock: int.tryParse(stockController.text) ?? 0,
                  imageUrl: imageUrlController.text.isEmpty
                      ? 'https://bogorcoklat.com/wp-content/uploads/2019/01/coklat-hadiah-valentine.jpeg'
                      : imageUrlController.text,
                );

                context.read<ProductBloc>().add(CreateProductEvent(product));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addRandomProducts(BuildContext context, {int count = 2}) {
    final random = Random();

    for (int i = 0; i < count; i++) {
      final product = Product(
        id: random.nextInt(100).toString(),
        name: 'Product ${random.nextInt(100)}',
        price: random.nextInt(500),
        category: 'Category ${random.nextInt(5) + 1}',
        description: 'This is a random product description ${random.nextInt(100)}',
        stock: random.nextInt(100),
        imageUrl: 'https://bogorcoklat.com/wp-content/uploads/2019/01/coklat-hadiah-valentine.jpeg',
      );

      context.read<ProductBloc>().add(CreateProductEvent(product));
    }
  }

  void deleteAllProducts(BuildContext context) {
    context.read<ProductBloc>().add(DeleteAllProductsEvent());
  }
}
