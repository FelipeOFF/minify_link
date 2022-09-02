import 'package:minify_link/domain/abstract_domain.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';

class CreateAliasFromLinkUseCase extends AbstractUseCase<String, LinkModel> {
  final IAliasRepository _repository;

  CreateAliasFromLinkUseCase(this._repository);

  @override
  Future<LinkModel> execute(String param) => _repository.getShortedLink(param);
}
