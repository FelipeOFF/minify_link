import 'package:get_it/get_it.dart';
import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/gateway/abstract_gateway.dart';

import '../gateway/mock/client/nubank_mock_client.dart';

class TestServiceBinding extends AbstractBinding {
  @override
  void binding(GetIt it) {
    it.registerSingleton<AbstractGateway>(NubankMockClient());
  }
}
