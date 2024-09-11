import '../entities/entities.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();

  Future<Product> createProduct(Product product);
}
