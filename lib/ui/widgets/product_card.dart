
import 'package:flutter/material.dart';
import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column( 
        children: [
          Image.network(product.images.isNotEmpty ? product.images[0] : ''), // Display first image
          ListTile(
            title: Text(product.title),
            subtitle: Text(product.description),
            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Category: ${product.category.name}'),
          ),
          // ... add more widgets to display other fields
        ],
      ),
    );
  }
}
