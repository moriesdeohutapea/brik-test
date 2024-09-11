import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/usecases/create_product.dart';
import 'features/products/domain/usecases/get_products.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: 'https://crudcrud.com/api/51fc81509d654c27b4c338a863730ee6')),
  );

  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProductRepositoryImpl>(
    () => ProductRepositoryImpl(remoteDataSource: getIt<ProductRemoteDataSource>()),
  );

  getIt.registerLazySingleton<GetProducts>(
    () => GetProducts(getIt<ProductRepositoryImpl>()),
  );

  getIt.registerLazySingleton<CreateProduct>(
    () => CreateProduct(getIt<ProductRepositoryImpl>()),
  );
}
