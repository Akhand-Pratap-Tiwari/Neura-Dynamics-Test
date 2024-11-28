
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product.dart';

class RemoteDataSource {
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
