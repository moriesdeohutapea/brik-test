import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import 'base_remote_data_source.dart';

class RemoteDataSource<T> implements BaseRemoteDataSource<T> {
  final Dio dio;
  final T Function(Map<String, dynamic>) fromJson;

  RemoteDataSource({
    required this.dio,
    required this.fromJson,
  });

  @override
  Future<T> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
      throw e;
    }
  }

  @override
  Future<List<T>> getList(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return (response.data as List).map((item) => fromJson(item)).toList();
    } on DioException catch (e) {
      _handleDioError(e);
      throw e;
    }
  }

  @override
  Future<T> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.post(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
      throw e;
    }
  }

  @override
  Future<T> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
      throw e;
    }
  }

  @override
  Future<void> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      await dio.delete(path, data: data);
    } on DioException catch (e) {
      _handleDioError(e);
      throw e;
    }
  }

  T _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return fromJson(response.data);
    } else {
      throw ServerException('Failed with status code: ${response.statusCode}');
    }
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw NetworkException('Connection timeout, please try again later.');
    } else if (e.type == DioExceptionType.badResponse) {
      throw ServerException('Server error: ${e.response?.statusCode}');
    } else if (e.type == DioExceptionType.unknown) {
      throw NetworkException('No internet connection or unknown network error.');
    } else {
      throw ServerException('Unexpected error occurred.');
    }
  }
}
