abstract class BaseRemoteDataSource<T> {
  Future<T> get(String path, {Map<String, dynamic>? queryParameters});

  Future<List<T>> getList(String path, {Map<String, dynamic>? queryParameters});

  Future<T> post(String path, {Map<String, dynamic>? data});

  Future<T> put(String path, {Map<String, dynamic>? data});

  Future<void> delete(String path, {Map<String, dynamic>? data});
}
