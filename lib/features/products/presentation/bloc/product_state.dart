import 'package:collection/collection.dart';

import '../../domain/entities/entities.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ProductInitial;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProductLoading extends ProductState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ProductLoading;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductLoaded(this.products, {this.hasReachedMax = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductLoaded &&
        const ListEquality().equals(other.products, products) &&
        other.hasReachedMax == hasReachedMax;
  }

  @override
  int get hashCode => Object.hash(
        const ListEquality().hash(products),
        hasReachedMax,
      );
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ProductCreated extends ProductState {
  final Product product;

  ProductCreated(this.product);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductCreated && other.product == product;
  }

  @override
  int get hashCode => product.hashCode;
}
