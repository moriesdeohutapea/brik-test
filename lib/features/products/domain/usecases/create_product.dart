import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../entities/entities.dart';

class CreateProduct implements UseCase<Product, Product> {
  final ProductRepositoryImpl repository;

  CreateProduct(this.repository);

  @override
  Future<Product> call(Product product) async {
    return await repository.createProduct(product);
  }
}
