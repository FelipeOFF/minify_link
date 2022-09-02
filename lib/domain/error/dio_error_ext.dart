import 'package:dio/dio.dart';
import 'package:minify_link/domain/error/generic_error.dart';
import 'package:minify_link/util/log.dart';

extension DioErrorExt on DioError {
  Future<GenericError> asGenericError() async {
    final data = response?.data;
    if (type == DioErrorType.connectTimeout ||
        type == DioErrorType.receiveTimeout) {
      return NetworkError(exception: this);
    }
    if (data != null && data is Map<String, dynamic>) {
      return DefaultError(
        code: response?.statusCode,
        message: data["error"] as String?,
        exception: this,
      );
    }
    logger.d("Data is not map or null: $data");
    return UnknownError(exception: this);
  }
}
