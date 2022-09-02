import 'package:flutter/material.dart';
import 'package:minify_link/commons/controller/base_controller.dart';
import 'package:minify_link/domain/error/generic_error.dart';
import 'package:minify_link/domain/usecase/alias/create_alias_from_link_usecase.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/res/strings/strings.dart';
import 'package:minify_link/util/string_ext.dart';

class HomeController extends BaseController {
  final CreateAliasFromLinkUseCase _createAliasFromLinkUseCase;

  HomeController(this._createAliasFromLinkUseCase);

  final linkNotifier = ValueNotifier<String?>(null);
  final linkShortenedNotifier = ValueNotifier<LinkModel?>(null);
  final linksListNotifier = ValueNotifier<List<LinkModel>>([]);

  String? get link => linkNotifier.value;

  set link(String? value) => linkNotifier.value = value;

  LinkModel? get linkShortened => linkShortenedNotifier.value;

  set linkShortened(LinkModel? value) => linkShortenedNotifier.value = value;

  List<LinkModel> get linksList => linksListNotifier.value;

  set linksList(List<LinkModel> value) => linksListNotifier.value = value;

  String? get linkError =>
      (linkNotifier.value?.isAValidURL ?? false) ? null : Strings.urlInvalid;

  Future<void> shortLink() async {
    if (link != null) {
      loading = true;
      final result = await _createAliasFromLinkUseCase(link!);
      result.fold(
        (error) => errorObject = error,
        (link) {
          linksList = List.from(linksList)..add(link);
          linkShortened = link;
        },
      );
      loading = false;
    } else {
      errorObject = UnknownError();
    }
  }
}
