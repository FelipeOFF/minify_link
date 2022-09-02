import 'package:flutter/material.dart';
import 'package:minify_link/modules/home/navigation/home_navigation.dart';
import 'package:minify_link/navigation/base_navigation.dart';
import 'package:minify_link/navigation/base_navigation_ext.dart';
import 'package:minify_link/res/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      initialRoute: "/",
      routes: <BaseNavigation>[
        HomeNavigation(),
      ].expandToMapper,
    );
  }
}
