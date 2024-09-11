import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../entities/entities.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepositoryImpl repository;

  GetProducts(this.repository);

  @override
  Future<List<Product>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
