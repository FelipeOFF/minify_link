import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minify_link/model/alias/req/Link_model_req.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/model/alias/res/reverse_link.dart';
import 'package:minify_link/repository/alias/alias_repository_impl.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';
import 'package:minify_link/service/endpoint.dart';
import 'package:minify_link/service/minify_api_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([MinifyApiClient])
import 'alias_repository_test.mocks.dart';

void main() {
  group("AliasRepository", () {
    final mockMinifyClient = MockMinifyApiClient();

    test(
      "On execute get shorted link and return success the shorted link",
      () async {
        final mockResultFromEndpoint = LinkModel.fromJson({
          "alias": "43290",
          "_links": {
            "self": "https://google.com.br/",
            "short": "https://url-shortener-nu.herokuapp.com/short/43290"
          }
        });

        const link = "https://google.com.br/";

        when(
          mockMinifyClient.post(
            Endpoint.apiAlias,
            data: LinkModelReq(url: link).toJson(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              data: mockResultFromEndpoint.toJson(),
              requestOptions: RequestOptions(path: Endpoint.apiAlias),
            ),
          ),
        );

        final IAliasRepository aliasRepository =
            AliasRepositoryImpl(mockMinifyClient);

        final result = await aliasRepository.getShortedLink(link);

        expect(result.alias, mockResultFromEndpoint.alias);
        expect(result.links?.self, mockResultFromEndpoint.links?.self);
      },
    );

    test(
      "On execute get shorted link and return error from server",
      () async {
        const link = "https://google.com.br/";
        const statusCode = 401;
        final requestOption = RequestOptions(path: Endpoint.apiAlias);

        when(
          mockMinifyClient.post(
            Endpoint.apiAlias,
            data: LinkModelReq(url: link).toJson(),
          ),
        ).thenThrow(
          DioError(
            requestOptions: requestOption,
            response: Response(
              statusCode: statusCode,
              requestOptions: requestOption,
            ),
          ),
        );

        final IAliasRepository aliasRepository =
            AliasRepositoryImpl(mockMinifyClient);

        try {
          await aliasRepository.getShortedLink(link);
        } on DioError catch (dioError) {
          expect(dioError.response?.statusCode, statusCode);
        }
      },
    );

    test(
      "On execute get reversed shorted link and return the real link",
      () async {
        const alias = "43290";
        final mockResultFromEndpoint = ReverseLink.fromJson({
          "url": "https://google.com.br/",
        });

        const endpoint = "${Endpoint.apiAlias}/$alias";

        when(
          mockMinifyClient.get(
            endpoint,
          ),
        ).thenAnswer(
          (_) => Future.value(
            Response(
              data: mockResultFromEndpoint.toJson(),
              requestOptions: RequestOptions(
                path: endpoint,
              ),
            ),
          ),
        );

        final IAliasRepository aliasRepository =
            AliasRepositoryImpl(mockMinifyClient);

        final result = await aliasRepository.getReverseLinkByAlias(alias);

        expect(result.url, mockResultFromEndpoint.url);
      },
    );

    test(
      "On execute get reversed shorted link and return 404",
      () async {
        const alias = "43290";
        const statusCode = 404;
        final requestOption = RequestOptions(path: Endpoint.apiAlias);

        const endpoint = "${Endpoint.apiAlias}/$alias";

        when(
          mockMinifyClient.get(
            endpoint,
          ),
        ).thenThrow(
          DioError(
            requestOptions: requestOption,
            response: Response(
              statusCode: statusCode,
              requestOptions: requestOption,
            ),
          ),
        );

        final IAliasRepository aliasRepository =
            AliasRepositoryImpl(mockMinifyClient);

        try {
          await aliasRepository.getReverseLinkByAlias(alias);
        } on DioError catch (dioError) {
          expect(dioError.response?.statusCode, statusCode);
        }
      },
    );
  });
}
