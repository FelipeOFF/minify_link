import 'dart:io';

import 'package:mockserver/src/mockserver/end_point.dart';

class MockServer {
  final int port;
  final int endPointDelay;
  late HttpServer _server;

  List<EndPoint> endPoints = [];

  MockServer({
    this.port = 8080,
    this.endPointDelay = 0,
  });

  void addEndpoints(List<EndPoint> list) {
    endPoints.clear();
    endPoints = [...list];
  }

  void clearAndAddNewEndPoint(EndPoint newEndpoint) {
    endPoints.clear();
    endPoints.add(newEndpoint);
  }

  Future<dynamic> start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv6, port);
    _server.listen(_onRequest);
  }

  Future<dynamic> stop() => _server.close();

  void _onRequest(HttpRequest request) {
    final HttpResponse response = request.response;

    try {
      final EndPoint? endPoint = _endPoint(request.method, request.uri.path);

      if (endPoint != null) {
        endPoint.processRequest(request, response, endPointDelay);
      } else {
        response.statusCode = StatusCode.NOT_FOUND;
        response.close();
      }
    } catch (e) {
      response.statusCode = StatusCode.INTERNAL_SERVER_ERROR;
      response.close();
    }
  }

  EndPoint? _endPoint(String method, String path) {
    for (final EndPoint endPoint in endPoints) {
      if (!endPoint.hasPathParameters && endPoint.match(method, path)) {
        return endPoint;
      }
    }

    for (final EndPoint endPoint in endPoints) {
      if (endPoint.match(method, path)) {
        return endPoint;
      }
    }

    return null;
  }
}
