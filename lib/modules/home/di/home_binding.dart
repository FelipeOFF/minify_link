import 'package:get_it/get_it.dart';
import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/modules/home/controller/home_controller.dart';

class HomeBinding extends AbstractBinding {
  @override
  void binding(GetIt it) {
    it.registerSingleton(HomeController(it()));
  }
}
