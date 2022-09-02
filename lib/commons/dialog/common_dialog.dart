import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/modules/home/dialog/informative_dialog.dart';
import 'package:minify_link/res/strings/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

InformativeDialog createInformativeDialogForShowLink(
  LinkModel linkShortened,
  BuildContext context,
) =>
    InformativeDialog(
      title: const Text(
        Strings.youShortedLinkHere,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      message: GestureDetector(
        onTap: () async {
          await _openShortLink(linkShortened);
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            const TextSpan(
              text: "Original link:\n",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: "${linkShortened.links?.self}\n\n",
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  final selfLink = linkShortened.links?.self;
                  if (selfLink != null) {
                    await launchUrlString(selfLink);
                  }
                },
            ),
            const TextSpan(
              text: "Shortened link:\n",
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: linkShortened.links?.short,
              style: const TextStyle(color: Colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  await _openShortLink(linkShortened);
                },
            ),
          ]),
        ),
      ),
      positiveButton: ElevatedButton(
        onPressed: () async {
          await _openShortLink(linkShortened);
        },
        child: const Text(Strings.open),
      ),
      negativeButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(Strings.close),
      ),
    );

Future<void> _openShortLink(LinkModel linkShortened) async {
  final shortLink = linkShortened.links?.short;
  if (shortLink != null) {
    await launchUrlString(shortLink);
  }
}
