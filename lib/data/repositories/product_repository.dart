import '../datasources/remote_data_source.dart';
import '../models/product.dart';

class ProductRepository {
  final RemoteDataSource remoteDataSource;

  ProductRepository({required this.remoteDataSource});

  Future<List<Product>> getProducts() async {
    return await remoteDataSource.fetchProducts();
  }
}
