import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../data/repositories/product_repository.dart';
import '../data/datasources/remote_data_source.dart';
import 'ui/screens/product_list_screen.dart';

void main() {
  runApp(const NeuraDemoApp());
}

class NeuraDemoApp extends StatelessWidget {
  const NeuraDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProductRepository>(
          create: (context) => ProductRepository(
            remoteDataSource: RemoteDataSource(),
          ),
        ),
        ChangeNotifierProvider<ProductController>(
          create: (context) => ProductController(
            productRepository: context.read<ProductRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Neura Dynamics Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
