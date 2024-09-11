import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../injection.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProductsUseCase = getIt<GetProducts>();
  final CreateProduct createProductUseCase = getIt<CreateProduct>();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<CreateProductEvent>(_onCreateProduct);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProductsUseCase(const NoParams());
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onCreateProduct(CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await createProductUseCase(event.product);
      emit(ProductCreated(product));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
