import 'package:get_it/get_it.dart';
import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/gateway/abstract_gateway.dart';
import 'package:minify_link/service/nubank_api_client.dart';

class ServiceBinding extends AbstractBinding {
  @override
  void binding(GetIt it) {
    it.registerSingleton<AbstractGateway>(NubankApiClient());
  }
}
