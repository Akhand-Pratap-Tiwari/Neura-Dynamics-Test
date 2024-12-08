import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import 'image_slider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // var testImg =
    //     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMkJEbqiXYbV2mdX3RmZvyYD9YwWjEo1k1q_UYQhGqOVvTtNKWTE7j57hUnaWrhoqtQHU&usqp=CAU";
    return Card(
      elevation: 4,
      // surfaceTintColor: Colors.blueGrey,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                          height: 128,
                          width: 128,
                          // child: ImageSlider(imageUrls: [testImg])
                          child: ImageSlider(imageUrls: product.images),
                          ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueGrey.shade100,
                    ),
                    child: Text(
                      "${product.category.name}",
                      style: TextStyle(color: Colors.blueGrey.shade600),
                    ),
                  ),
                ],
              ),
              Flexible(
                child: ListTile(
                  isThreeLine: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        // margin: EdgeInsets.only(left: 2),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '₹${product.price.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  ),
                  subtitle: Text(
                    product.description,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
