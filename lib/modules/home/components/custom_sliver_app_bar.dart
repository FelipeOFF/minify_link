import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minify_link/modules/home/components/short_form_widget.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      collapsedHeight: 80,
      expandedHeight: 140,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        centerTitle: true,
        title: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 4.0,
            sigmaX: 4.0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ShortFormWidget(formKey: _formKey),
          ),
        ),
      ),
    );
  }
}
