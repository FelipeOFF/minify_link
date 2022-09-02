import 'package:minify_link/gateway/abstract_gateway.dart';
import 'package:minify_link/res/env/profile.dart';
import 'package:minify_link/service/util/urls_from_profile_ext.dart';

class MinifyApiClient extends AbstractGateway {
  @override
  String get url => getProfileFromEnvironmentConfig()!.url;
}
