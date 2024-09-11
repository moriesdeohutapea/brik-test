import '../entities/entities.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({required int page, required int perPage});

  Future<Product> createProduct(Product product);
}
