import 'package:minify_link/gateway/abstract_gateway.dart';

class NubankMockClient extends AbstractGateway {
  @override
  String get url => "http://localhost:8080";
}
