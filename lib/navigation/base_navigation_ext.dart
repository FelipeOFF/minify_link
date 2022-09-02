import 'package:flutter/material.dart';
import 'package:minify_link/navigation/base_navigation.dart';

extension BaseNavigationListExt on List<BaseNavigation> {
  Map<String, WidgetBuilder> get expandToMapper =>
      <String, WidgetBuilder>{for (final map in this) ...map.listOfPages};
}
