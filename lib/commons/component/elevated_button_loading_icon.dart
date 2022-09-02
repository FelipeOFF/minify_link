import 'package:flutter/material.dart';
import 'package:minify_link/commons/controller/base_controller.dart';

class ElevatedButtonLoadingIcon extends StatelessWidget {
  final BaseController controller;
  final GlobalKey<FormState> _formKey;
  final VoidCallback? onPressed;
  final Icon icon;

  const ElevatedButtonLoadingIcon({
    Key? key,
    required this.controller,
    required GlobalKey<FormState> formKey,
    this.onPressed,
    required this.icon,
  })  : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: controller.loadingNotifier,
      builder: (_, value, child) => ElevatedButton(
        onPressed: !value
            ? (onPressed != null)
                ? _validateAndExecuteOnPressedFather
                : null
            : null,
        child: value
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : child ?? icon,
      ),
      child: icon,
    );
  }

  void _validateAndExecuteOnPressedFather() {
    if (controller.loading == false) {
      final isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        return onPressed?.call();
      }
    }
  }
}
