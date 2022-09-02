import 'dart:io';

import 'package:mockserver/mockserver.dart';

import '../body_response.dart';

class GetApiAliasId404Test extends EndPoint {
  GetApiAliasId404Test() : super(method: "GET", path: "/api/alias/43291");

  @override
  Future<void> process(HttpRequest request, HttpResponse response) async {
    response.statusCode = 404;
    response.writeJson(getApiAliasEndpoint404ResponseBody);
    await response.close();
  }
}
