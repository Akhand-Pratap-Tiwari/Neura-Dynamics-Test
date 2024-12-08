import 'package:flutter/material.dart';
import '../data/repositories/product_repository.dart';
import '../data/models/product.dart';

class ProductController with ChangeNotifier {
  final ProductRepository productRepository;
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  List<String> _categories = [];

  ProductController({required this.productRepository});

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<String> get categories => _categories;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await productRepository.getProducts();
      _categories = _products.map((e) => e.category.name,).toSet().toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
