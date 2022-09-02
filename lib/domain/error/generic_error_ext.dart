import 'package:minify_link/domain/error/generic_error.dart';

extension GenericErrorExt on GenericError {
  NetworkError? get asNetworkException => this as NetworkError?;
  DefaultError? get asDefaultError => this as DefaultError?;
  UnknownError? get asUnknownError => this as UnknownError?;
}
