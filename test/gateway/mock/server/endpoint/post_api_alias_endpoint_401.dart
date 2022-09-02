import 'dart:io';

import 'package:mockserver/mockserver.dart';

import '../body_response.dart';

class PostApiAliasEndpoint401Test extends EndPoint {
  PostApiAliasEndpoint401Test() : super(method: "POST", path: "/api/alias");

  @override
  Future<void> process(HttpRequest request, HttpResponse response) async {
    response.statusCode = 401;
    response.headers.add("Content-Type", "application/json");
    response.writeJson(getApiAliasEndpoint404ResponseBody);
    await response.close();
  }
}
