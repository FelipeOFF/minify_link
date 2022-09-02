import 'package:get_it/get_it.dart';
import 'package:minify_link/di/abstract_binding.dart';
import 'package:minify_link/domain/usecase/alias/create_alias_from_link_usecase.dart';
import 'package:minify_link/domain/usecase/alias/get_real_link_by_alias_code_usecase.dart';

class DomainBinding extends AbstractBinding {
  @override
  void binding(GetIt it) {
    it.registerSingleton(CreateAliasFromLinkUseCase(it()));
    it.registerSingleton(GetRealLinkByAliasCodeUseCase(it()));
  }
}
