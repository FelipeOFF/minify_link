import 'package:flutter/material.dart';
import 'package:minify_link/commons/controller/base_controller.dart';
import 'package:minify_link/di/app_di.dart';
import 'package:minify_link/domain/error/generic_error.dart';
import 'package:minify_link/domain/error/generic_error_ext.dart';
import 'package:minify_link/modules/home/dialog/informative_dialog.dart';
import 'package:minify_link/res/strings/strings.dart';

abstract class BaseStatePage<T extends StatefulWidget, C extends BaseController>
    extends State<T> {
  final C controller = AppDI.it<C>();

  @override
  void initState() {
    super.initState();
    controller.errorObjectNotifier.addListener(_listenerOnError);
  }

  @override
  void dispose() {
    controller.errorObjectNotifier.removeListener(_listenerOnError);
    super.dispose();
  }

  void _listenerOnError() {
    final error = controller.errorObject;
    if (error != null) {
      showDialogErrorFromGenericError(error);
      controller.errorObject = null;
    }
  }

  void showDialogErrorFromGenericError(GenericError error) {
    final errorMessage = _getErrorMessageFromGenericError(error);
    InformativeDialog(
      icon: const Icon(Icons.error),
      title: const Text(
        Strings.genericErrorTitle,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      message: Text(
        errorMessage,
        textAlign: TextAlign.center,
      ),
      positiveButton: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text(Strings.ok),
      ),
    ).showBottomSheetDialog(context);
  }

  String _getErrorMessageFromGenericError(GenericError error) {
    switch (error.runtimeType) {
      case DefaultError:
        return error.asDefaultError?.message ?? Strings.genericError;
      case NetworkError:
        return Strings.deviceWithoutNetwork;
      case UnknownError:
        return Strings.genericError;
      default:
        return Strings.genericError;
    }
  }
}
