import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../injection.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/get_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProductsUseCase = getIt<GetProducts>();
  final CreateProduct createProductUseCase = getIt<CreateProduct>();

  int _currentPage = 1;
  final int _perPage = 10;
  bool _hasReachedMax = false;
  final List<Product> _allProducts = [];

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<CreateProductEvent>(_onCreateProduct);
    on<DeleteAllProductsEvent>(_onDeleteAllProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    if (_hasReachedMax && event.page != 1) return;
    if (event.page == 1) {
      _resetPagination();
      emit(ProductLoading());
    }
    try {
      final products = await getProductsUseCase(GetProductsParams(page: event.page, perPage: _perPage));
      _hasReachedMax = products.length < _perPage;

      if (event.page == 1) {
        _allProducts.clear();
      }
      _allProducts.addAll(products);

      if (state is ProductLoaded && event.page != 1) {
        final updatedProducts = List<Product>.from((state as ProductLoaded).products)..addAll(products);
        emit(ProductLoaded(updatedProducts, hasReachedMax: _hasReachedMax));
      } else {
        emit(ProductLoaded(products, hasReachedMax: _hasReachedMax));
      }
    } catch (e) {
      if (e is ServerException) {
        emit(ProductError('Failed to fetch products: ${e.message}'));
      } else {
        emit(ProductError('An unknown error occurred.'));
      }
    }
  }

  Future<void> _onCreateProduct(CreateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final product = await createProductUseCase(event.product);
      _allProducts.add(product);
      emit(ProductCreated(product));
    } catch (e) {
      if (e is ServerException) {
        emit(ProductError('Failed to create product: ${e.message}'));
      } else {
        emit(ProductError('An unknown error occurred.'));
      }
    }
  }

  Future<void> _onDeleteAllProducts(DeleteAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    _allProducts.clear();
    emit(ProductLoaded([], hasReachedMax: true));
  }

  void _onSearchProducts(SearchProductsEvent event, Emitter<ProductState> emit) {
    if (event.query.isEmpty) {
      emit(ProductLoaded(List.from(_allProducts), hasReachedMax: _hasReachedMax));
    } else {
      final results = _allProducts.where((product) => product.name.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(ProductLoaded(results, hasReachedMax: _hasReachedMax));
    }
  }

  void _resetPagination() {
    _currentPage = 1;
    _hasReachedMax = false;
  }
}
