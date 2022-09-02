import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/model/alias/res/reverse_link.dart';

abstract class IAliasRepository {
  Future<LinkModel> getShortedLink(String link);
  Future<ReverseLink> getReverseLinkByAlias(String alias);
}
