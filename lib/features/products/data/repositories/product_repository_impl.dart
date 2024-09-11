import '../../../../core/error/exceptions.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Product> createProduct(Product product) async {
    final response = await remoteDataSource.createProduct(product);
    if (response.statusCode == 200) {
      return response.data!;
    } else {
      throw ServerException('Failed to create product: ${response.message}');
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    final response = await remoteDataSource.getProducts();
    if (response.statusCode == 200) {
      return response.data!;
    } else {
      throw ServerException('Failed to fetch products: ${response.message}');
    }
  }
}
