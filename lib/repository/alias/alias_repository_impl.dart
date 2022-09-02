import 'package:minify_link/gateway/abstract_gateway.dart';
import 'package:minify_link/model/alias/req/link_model_req.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/model/alias/res/reverse_link.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';
import 'package:minify_link/service/endpoint.dart';

class AliasRepositoryImpl extends IAliasRepository {
  final AbstractGateway _nubankApiClient;

  AliasRepositoryImpl(this._nubankApiClient);

  @override
  Future<LinkModel> getShortedLink(String link) async {
    final req = await _nubankApiClient.post(
      Endpoint.apiAlias,
      data: LinkModelReq(url: link).toJson(),
    );
    return LinkModel.fromJson(req.data);
  }

  @override
  Future<ReverseLink> getReverseLinkByAlias(String alias) async {
    final req = await _nubankApiClient.get(
      "${Endpoint.apiAlias}/$alias",
    );
    return ReverseLink.fromJson(req.data);
  }
}
