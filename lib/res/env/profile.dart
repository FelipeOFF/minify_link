import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:minify_link/res/env/environment_config.dart';

enum Profile { dev, hml, prod }

Profile? getProfileFromString(String value) => Profile.values
    .firstWhereOrNull((element) => describeEnum(element) == value);

Profile? getProfileFromEnvironmentConfig() => Profile.values.firstWhereOrNull(
      (element) => describeEnum(element) == EnvironmentConfig.profile,
    );
