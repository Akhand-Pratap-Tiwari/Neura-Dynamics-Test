
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../utils/utils.dart';
import '../models/product.dart';

class RemoteDataSource {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Product> prodList = jsonList.map((json) => refine(Product.fromJson(json))).toList();
      debugPrint("debug: ${prodList.length}");
      for (var element in prodList) {
        displayProduct(element);
      }
      return prodList;
    } else {
      throw Exception('Failed to load products');
    }
  }
}