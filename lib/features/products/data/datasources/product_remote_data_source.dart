import 'package:brik_test/features/products/data/datasources/remote_data_source.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/entities.dart';
import '../models/model.dart';

class ProductRemoteDataSource {
  final RemoteDataSource<Product> remoteDataSource;
  final Dio dio;

  ProductRemoteDataSource({required this.dio})
      : remoteDataSource = RemoteDataSource<Product>(
          dio: dio,
          fromJson: (json) => Product.fromJson(json as Map<String, dynamic>),
        );

  Future<BaseResponse<Product>> createProduct(Product product) async {
    try {
      final response = await dio.post('/products', data: product.toJson());
      return BaseResponse<Product>.fromJson(
        {
          'statusCode': response.statusCode,
          'message': 'Product created successfully',
          'data': response.data,
        },
        (data) => Product.fromJson(data as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      throw ServerException('Failed to create product: ${e.response?.data['message'] ?? e.message}');
    }
  }

  Future<BaseResponse<List<Product>>> getProducts({required int page, required int perPage}) async {
    try {
      final response = await dio.get(
        '/products',
        queryParameters: {
          'page': page,
          'perPage': perPage,
        },
      );

      return BaseResponse<List<Product>>.fromJson(
        {
          'statusCode': response.statusCode,
          'message': 'Success',
          'data': response.data,
        },
        (data) => (data as List<dynamic>).map((item) => Product.fromJson(item as Map<String, dynamic>)).toList(),
      );
    } on DioException catch (e) {
      throw ServerException('Failed to fetch products: ${e.response?.data['message'] ?? e.message}');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await dio.delete('/products/$productId');
    } on DioException catch (e) {
      throw ServerException('Failed to delete product: ${e.response?.data['message'] ?? e.message}');
    }
  }
}
