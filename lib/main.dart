import 'package:flutter/material.dart';
import 'package:minify_link/app/app.dart';
import 'package:minify_link/di/app_di.dart';

void main() {
  AppDI().setupDI();
  runApp(const App());
}
