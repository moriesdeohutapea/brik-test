class BaseResponse<T> {
  final int statusCode;
  final String message;
  final T? data;

  BaseResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) {
    return BaseResponse(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data != null ? toJsonT(data!) : null,
    };
  }
}