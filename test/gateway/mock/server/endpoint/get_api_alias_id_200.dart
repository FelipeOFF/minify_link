import 'dart:io';

import 'package:mockserver/mockserver.dart';

import '../body_response.dart';

class GetApiAliasId200Test extends EndPoint {
  GetApiAliasId200Test() : super(method: "GET", path: "/api/alias/43290");

  @override
  Future<void> process(HttpRequest request, HttpResponse response) async {
    response.statusCode = 200;
    response.writeJson(getApiAliasEndpoint200ResponseBody);
    await response.close();
  }
}
