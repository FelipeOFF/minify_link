import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock/client/nubank_mock_client.dart';
import 'mock/server/body_response.dart';
import 'mock/server/endpoint/get_api_alias_id_200.dart';
import 'mock/server/endpoint/get_api_alias_id_404.dart';
import 'mock/server/endpoint/post_api_alias_endpoint_200.dart';
import 'mock/server/mock_server.dart';

void main() {
  final MockServer mockServer = MockServer()
    ..addEndpoints([
      PostApiAliasEndpoint200Test(),
      GetApiAliasId200Test(),
      GetApiAliasId404Test(),
    ]);

  setUpAll(() async {
    await mockServer.start();
  });

  tearDownAll(() async {
    await mockServer.stop();
  });

  group("Test Abstract Gateway ", () {
    test(
      "execute endpoint POST /api/alias with a link and return the short link",
      () async {
        final NubankMockClient client = NubankMockClient();

        const Map<String, dynamic> dataRequest = {
          "url": "https://nubank.com.br/"
        };
        final dataResponse = await client.post("/api/alias", data: dataRequest);
        final dataJson = dataResponse.data;

        expect(dataJson, postApiAliasEndpoint200ResponseBody);
        expect(dataResponse.statusCode, 200);
      },
    );

    test(
      "execute endpoint GET /api/alias/id with correct id and return the normal link",
      () async {
        final NubankMockClient client = NubankMockClient();

        final dataResponse = await client.get("/api/alias/43290");
        final dataJson = json.decode(dataResponse.data as String);

        expect(dataJson, getApiAliasEndpoint200ResponseBody);
        expect(dataResponse.statusCode, 200);
      },
    );

    test(
      "execute endpoint GET /api/alias/id with wrong id and return the normal link",
      () async {
        final NubankMockClient client = NubankMockClient();
        try {
          final dataResponse = await client.get("/api/alias/43291");
          expect(dataResponse, null);
        } on DioError catch (dioError) {
          expect(dioError.response?.statusCode, 404);
        }
      },
    );
  });
}
