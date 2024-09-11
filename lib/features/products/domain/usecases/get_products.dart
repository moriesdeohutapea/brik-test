import '../../../../core/usecases/usecase.dart';
import '../entities/entities.dart';
import '../repositories/product_repository.dart';

class GetProducts implements UseCase<List<Product>, GetProductsParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<List<Product>> call(GetProductsParams params) async {
    return await repository.getProducts(page: params.page, perPage: params.perPage);
  }
}

class GetProductsParams {
  final int page;
  final int perPage;

  GetProductsParams({required this.page, required this.perPage});
}
