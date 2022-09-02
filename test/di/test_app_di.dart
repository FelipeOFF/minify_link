import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/di/app_di.dart';
import 'package:minify_link/di/service/service_binding.dart';

import 'test_service_binding.dart';

class TestAppDi extends AppDI {
  @override
  List<AbstractBinding> getListOfBinding() => [
        TestServiceBinding(),
        ...super.getListOfBinding()
          ..removeWhere((element) => element is ServiceBinding),
      ];
}
