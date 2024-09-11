import '../../domain/entities/entities.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts({required int page, required int perPage}) async {
    final response = await remoteDataSource.getProducts(page: page, perPage: perPage);
    return response.data ?? [];
  }

  @override
  Future<Product> createProduct(Product product) async {
    final response = await remoteDataSource.createProduct(product);
    return response.data!;
  }
}
