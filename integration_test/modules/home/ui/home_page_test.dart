import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:minify_link/app/app.dart';
import 'package:minify_link/commons/component/elevated_button_loading_icon.dart';
import 'package:minify_link/res/strings/strings.dart';

import '../../../../test/di/test_app_di.dart';
import '../../../../test/gateway/mock/server/endpoint/post_api_alias_endpoint_200.dart';
import '../../../../test/gateway/mock/server/endpoint/post_api_alias_endpoint_401.dart';
import '../../../../test/gateway/mock/server/mock_server.dart';

Future<void> waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);

  do {
    if (DateTime.now().isAfter(end)) {
      throw Exception('Timed out waiting for $finder');
    }

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 100));
  } while (finder.evaluate().isEmpty);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final MockServer mockServer = MockServer();

  setUpAll(() async {
    await mockServer.start();
  });

  tearDownAll(() async {
    await mockServer.stop();
  });

  group("Test Home Page", () {
    TestAppDi().setupDI();

    testWidgets(
      "Write a invalid URL and show error below TextFormField",
      (tester) async {
        runApp(const App());

        await tester.pumpAndSettle();

        const url = "localhost";

        final textField = find.byType(TextFormField);
        final button = find.byType(ElevatedButtonLoadingIcon);

        await tester.enterText(textField, url);
        await tester.tap(button);

        await tester.pump(const Duration(microseconds: 100));

        final messageWidget = find.text(Strings.urlInvalid);

        expect(textField, findsOneWidget);
        expect(messageWidget, findsOneWidget);
      },
    );

    testWidgets(
      "Write a valid URL and server return 200",
      (tester) async {
        mockServer.clearAndAddNewEndPoint(PostApiAliasEndpoint200Test());

        runApp(const App());

        await tester.pumpAndSettle();

        const url = "https://google.com.br";

        final textField = find.byType(TextFormField);
        final button = find.byType(ElevatedButtonLoadingIcon);

        await tester.enterText(textField, url);
        await tester.tap(button);

        await tester.pumpAndSettle();

        final messageWidget =
            find.text("https://url-shortener-nu.herokuapp.com/short/43290");

        final buttonToClose = find.text(Strings.close);

        await waitFor(tester, messageWidget);
        await waitFor(tester, buttonToClose);

        await tester.tap(buttonToClose);

        expect(textField, findsOneWidget);
        expect(buttonToClose, findsOneWidget);
        expect(messageWidget, findsOneWidget);
      },
    );

    testWidgets(
      "Write a valid URL and server return 401 with backend error message",
      (tester) async {
        mockServer.clearAndAddNewEndPoint(PostApiAliasEndpoint401Test());

        runApp(const App());

        await tester.pumpAndSettle();

        const url = "https://google.com.br";

        final textField = find.byType(TextFormField);
        final button = find.byType(ElevatedButtonLoadingIcon);

        await tester.enterText(textField, url);
        await tester.tap(button);

        await tester.pumpAndSettle();

        final messageWidget = find.text("Alias for 43291 not found");
        final buttonToClose = find.text(Strings.ok);

        await waitFor(tester, messageWidget);
        await waitFor(tester, buttonToClose);

        await tester.tap(buttonToClose);

        expect(textField, findsOneWidget);
        expect(buttonToClose, findsOneWidget);
        expect(messageWidget, findsOneWidget);
      },
    );
  });
}
