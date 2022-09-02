import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:minify_link/domain/error/generic_error.dart';
import 'package:minify_link/domain/error/generic_error_ext.dart';
import 'package:minify_link/domain/usecase/alias/get_real_link_by_alias_code_usecase.dart';
import 'package:minify_link/model/alias/res/reverse_link.dart';
import 'package:minify_link/repository/alias/i_alias_repository.dart';
import 'package:minify_link/service/endpoint.dart';
import 'package:minify_link/util/either_helpers.dart';

@GenerateMocks([IAliasRepository])
import "get_real_link_by_alias_code_usecase_test.mocks.dart";

void main() {
  group("GetRealLinkByAliasCodeUseCase", () {
    final aliasRepository = MockIAliasRepository();

    test(
      "on execute get real link giving alias, then return a reverse link",
      () async {
        const alias = "43290";
        final reverseLink = ReverseLink.fromJson({
          "url": "https://nubank.com.br/",
        });

        when(aliasRepository.getReverseLinkByAlias(alias))
            .thenAnswer((_) => Future.value(reverseLink));

        final getRealLinkByAliasCodeUseCase =
            GetRealLinkByAliasCodeUseCase(aliasRepository);

        final Either<GenericError, ReverseLink> result =
            await getRealLinkByAliasCodeUseCase(alias);

        expect(reverseLink.url, result.unwrapRight()?.url);
      },
    );

    test(
      "on execute get real link giving alias, then return a error from server",
      () async {
        const alias = "43291";
        const statusCode = 404;
        final requestOption =
            RequestOptions(path: "${Endpoint.apiAlias}/$alias");
        final dataError = {"error": "Alias for 43291 not found"};

        when(aliasRepository.getReverseLinkByAlias(alias)).thenThrow(
          DioError(
            requestOptions: requestOption,
            response: Response(
              data: dataError,
              statusCode: statusCode,
              requestOptions: requestOption,
            ),
          ),
        );

        final getRealLinkByAliasCodeUseCase =
            GetRealLinkByAliasCodeUseCase(aliasRepository);

        final Either<GenericError, ReverseLink> result =
            await getRealLinkByAliasCodeUseCase(alias);

        final dioError = result.swap().unwrapRight()?.asDefaultError;

        expect(dioError?.message, dataError["error"]);
      },
    );
  });
}
