import 'package:flutter/material.dart';
import '../data/repositories/product_repository.dart';
import '../data/models/product.dart';

class ProductController with ChangeNotifier {
  final ProductRepository productRepository;
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  ProductController({required this.productRepository});

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await productRepository.getProducts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
