import 'package:minify_link/gateway/urls.dart';
import 'package:minify_link/res/env/profile.dart';

extension UrlsFromProfileExt on Profile {
  String get url {
    switch (getProfileFromEnvironmentConfig()) {
      case Profile.dev:
        return Urls.baseURL;
      case Profile.hml:
        return Urls.baseURL;
      case Profile.prod:
        return Urls.baseURL;
      default:
        return Urls.baseURL;
    }
  }
}
