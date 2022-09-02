import 'package:get_it/get_it.dart';
import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/repository/alias/alias_repository_impl.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';

class RepositoryBinding extends AbstractBinding {
  @override
  void binding(GetIt it) {
    it.registerSingleton<IAliasRepository>(AliasRepositoryImpl(it()));
  }
}
