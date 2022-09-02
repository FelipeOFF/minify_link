import 'package:minify_link/domain/abstract_domain.dart';
import 'package:minify_link/model/alias/res/reverse_link.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';

class GetRealLinkByAliasCodeUseCase
    extends AbstractUseCase<String, ReverseLink> {
  final IAliasRepository _aliasRepository;

  GetRealLinkByAliasCodeUseCase(this._aliasRepository);

  @override
  Future<ReverseLink> execute(String param) =>
      _aliasRepository.getReverseLinkByAlias(param);
}
