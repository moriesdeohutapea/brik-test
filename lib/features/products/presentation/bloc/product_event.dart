import '../../domain/entities/entities.dart';

abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final int page;

  FetchProducts(this.page);
}

class CreateProductEvent extends ProductEvent {
  final Product product;

  CreateProductEvent(this.product);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateProductEvent && other.product == product;
  }

  @override
  int get hashCode => product.hashCode;
}

class DeleteAllProductsEvent extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;

  SearchProductsEvent(this.query);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchProductsEvent && other.query == query;
  }

  @override
  int get hashCode => query.hashCode;
}
