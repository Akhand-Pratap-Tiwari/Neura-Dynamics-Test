import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/product_controller.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductController>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          if (productController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productController.error != null) {
            return Center(child: Text('Error: ${productController.error}'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: productController.products[index]);
              },
            );
          }
        },
      ),
    );
  }
}
