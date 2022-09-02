import 'dart:io';

import 'package:mockserver/mockserver.dart';

import '../body_response.dart';

class PostApiAliasEndpoint200Test extends EndPoint {
  PostApiAliasEndpoint200Test() : super(method: "POST", path: "/api/alias");

  @override
  Future<void> process(HttpRequest request, HttpResponse response) async {
    response.statusCode = 200;
    response.headers.add("Content-Type", "application/json");
    response.writeJson(postApiAliasEndpoint200ResponseBody);
    await response.close();
  }
}
