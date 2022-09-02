import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:minify_link/res/env/environment_config.dart';
import 'package:minify_link/util/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class AbstractGateway extends DioForNative {
  abstract final String url;

  AbstractGateway() : super() {
    options = _getBaseOptions();
    interceptors.addAll(
      _getInterceptors().whereType(),
    );
  }

  BaseOptions _getBaseOptions() => BaseOptions(
        baseUrl: url,
        sendTimeout: sendTimeout,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      );

  List<Interceptor?> _getInterceptors() => [
        getLogger(),
      ];

  Interceptor getLogger() => PrettyDioLogger(
        error: EnvironmentConfig.isLoggingEnable,
        request: EnvironmentConfig.isLoggingEnable,
        responseBody: EnvironmentConfig.isLoggingEnable,
        compact: EnvironmentConfig.isLoggingEnable,
        // The variable is from environment and can be true
        // ignore: avoid_redundant_argument_values
        requestHeader: EnvironmentConfig.isLoggingEnable,
        // The variable is from environment and can be true
        // ignore: avoid_redundant_argument_values
        responseHeader: EnvironmentConfig.isLoggingEnable,
        // The variable is from environment and can be true
        // ignore: avoid_redundant_argument_values
        requestBody: EnvironmentConfig.isLoggingEnable,
      );
}
