import 'package:minify_link/gateway/abstract_gateway.dart';

class MinifyMockClient extends AbstractGateway {
  @override
  String get url => "http://localhost:8080";
}
