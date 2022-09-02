import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:minify_link/domain/error/generic_error.dart';
import 'package:minify_link/domain/error/generic_error_ext.dart';
import 'package:minify_link/domain/usecase/alias/create_alias_from_link_usecase.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';
import 'package:minify_link/service/endpoint.dart';
import 'package:minify_link/util/either_helpers.dart';

@GenerateMocks([IAliasRepository])
import "create_alias_from_link_domain_test.mocks.dart";

void main() {
  group("CreateAliasFromLinkDomain", () {
    final aliasRepository = MockIAliasRepository();

    test("on execute the use case and return short link", () async {
      const link = "https://nubank.com.br";
      final linkModel = LinkModel.fromJson({
        "alias": "43290",
        "_links": {
          "self": "https://nubank.com.br/",
          "short": "https://url-shortener-nu.herokuapp.com/short/43290"
        }
      });

      when(aliasRepository.getShortedLink(link))
          .thenAnswer((_) => Future.value(linkModel));

      final createAliasFromLinkUseCase =
          CreateAliasFromLinkUseCase(aliasRepository);

      final Either<GenericError, LinkModel> result =
          await createAliasFromLinkUseCase(link);

      expect(linkModel.alias, result.unwrapRight()?.alias);
      expect(linkModel.links?.short, result.unwrapRight()?.links?.short);
    });

    test("on execute the use case and return a error", () async {
      const link = "https://nubank.com.br";
      const statusCode = 401;
      final requestOption = RequestOptions(path: Endpoint.apiAlias);
      final dataError = {"error": "Alias for 43291 not found"};

      when(aliasRepository.getShortedLink(link)).thenThrow(
        DioError(
          requestOptions: requestOption,
          response: Response(
            data: dataError,
            statusCode: statusCode,
            requestOptions: requestOption,
          ),
        ),
      );

      final createAliasFromLinkUseCase =
          CreateAliasFromLinkUseCase(aliasRepository);

      final Either<GenericError, LinkModel> result =
          await createAliasFromLinkUseCase(link);

      final dioError = result.swap().unwrapRight()?.asDefaultError;

      expect(dioError?.code, statusCode);
      expect(dioError?.message, dataError["error"]);
    });
  });
}
