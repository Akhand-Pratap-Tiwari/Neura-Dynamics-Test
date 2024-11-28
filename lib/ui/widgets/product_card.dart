import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import 'image_slider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // var test_img = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMkJEbqiXYbV2mdX3RmZvyYD9YwWjEo1k1q_UYQhGqOVvTtNKWTE7j57hUnaWrhoqtQHU&usqp=CAU";
    return Card(
      elevation: 4,
      // surfaceTintColor: Colors.blueGrey,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: ImageSlider(imageUrls: product.images)),
          Flexible(
            child: ListTile(
              isThreeLine: true,
              title: Text(product.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category: ${product.category.name}',
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                  Text(product.description),
                ],
              ),
              trailing: Text(
                '₹${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
