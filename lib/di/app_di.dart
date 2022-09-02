import 'package:get_it/get_it.dart';
import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/di/domain/domain_binding.dart';
import 'package:minify_link/di/repository/repository_binding.dart';
import 'package:minify_link/di/service/service_binding.dart';
import 'package:minify_link/modules/home/di/home_binding.dart';

class AppDI {
  static final GetIt it = GetIt.instance;

  List<AbstractBinding> getListOfBinding() => [
        ServiceBinding(),
        RepositoryBinding(),
        DomainBinding(),
        HomeBinding(),
      ];

  void setupDI() {
    for (final element in getListOfBinding()) {
      element.binding(it);
    }
  }
}
