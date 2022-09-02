import 'package:flutter/material.dart';
import 'package:minify_link/commons/component/elevated_button_loading_icon.dart';
import 'package:minify_link/di/app_di.dart';
import 'package:minify_link/modules/home/controller/home_controller.dart';
import 'package:minify_link/res/strings/strings.dart';

class ShortFormWidget extends StatelessWidget {
  final HomeController _homeController = AppDI.it();
  final GlobalKey<FormState> _formKey;

  ShortFormWidget({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 8,
            child: TextFormField(
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: Strings.addHereALink,
                errorText: '',
              ),
              onChanged: (value) {
                _homeController.link = value;
              },
              validator: (_) => _homeController.linkError,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButtonLoadingIcon(
            controller: _homeController,
            formKey: _formKey,
            icon: const Icon(
              Icons.send,
              color: Colors.black,
            ),
            onPressed: _homeController.shortLink,
          )
        ],
      ),
    );
  }
}
