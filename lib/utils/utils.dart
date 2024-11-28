import 'package:flutter/material.dart';
import 'package:myapp/data/models/product.dart';

String extractLink(String formattedString) {
  // 1. Remove brackets and quotes
  String cleanedString = formattedString
      .replaceAll('[', '')
      .replaceAll(']', '')
      .replaceAll('"', '')
      .replaceAll("'", '');

  // 2. Split by comma (if multiple links are present)
  List<String> links = cleanedString.split(',');

  // 3. Return the first link (or handle multiple links as needed)
  return links.isNotEmpty ? links[0] : '';
}

Product refine(Product prod) {
  List<String> refinedImageLinks =
      prod.images.map((link) => extractLink(link)).toList();
  return Product(
    id: prod.id,
    title: prod.title,
    price: prod.price,
    description: prod.description,
    images: refinedImageLinks,
    createdAt: prod.createdAt,
    updatedAt: prod.updatedAt,
    category: prod.category
  );
}

void displayProduct(Product prod) {
  debugPrint("debug: ${prod.images}");
}