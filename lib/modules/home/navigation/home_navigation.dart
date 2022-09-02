import 'package:flutter/material.dart';
import 'package:minify_link/modules/home/ui/home_page.dart';
import 'package:minify_link/navigation/app_routes.dart';
import 'package:minify_link/navigation/base_navigation.dart';

class HomeNavigation extends BaseNavigation {
  @override
  Map<String, WidgetBuilder> get listOfPages => {
        AppRoutes.initial: (_) => const HomePage(),
      };
}
