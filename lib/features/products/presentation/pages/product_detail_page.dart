import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Category: ${product.category}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: \$${product.price}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${product.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Stock: ${product.stock}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            product.imageUrl.isNotEmpty
                ? Image.network(
                    product.imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const Text('No Image Available'),
          ],
        ),
      ),
    );
  }
}
