
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../data/repositories/product_repository.dart';
import '../data/datasources/remote_data_source.dart';
import 'ui/screens/product_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ProductListScreen(),
      ),
    );
  }
}
