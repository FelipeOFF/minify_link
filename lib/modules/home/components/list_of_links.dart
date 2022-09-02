import 'package:flutter/material.dart';
import 'package:minify_link/commons/dialog/common_dialog.dart';
import 'package:minify_link/di/app_di.dart';
import 'package:minify_link/model/alias/res/link_model.dart';
import 'package:minify_link/modules/home/controller/home_controller.dart';

class ListOfLinks extends StatelessWidget {
  ListOfLinks({
    Key? key,
  }) : super(key: key);

  final HomeController _homeController = AppDI.it();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<LinkModel>>(
      builder: (BuildContext context, value, Widget? child) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final linkModel = value[index];
              return Column(
                children: [
                  if (index > 0) const Divider(height: 0),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 23.0),
                    onTap: () {
                      createInformativeDialogForShowLink(
                        linkModel,
                        context,
                      ).showBottomSheetDialog(context);
                    },
                    title: Text(linkModel.links?.short ?? ""),
                    subtitle: Text(linkModel.alias ?? ""),
                  ),
                ],
              );
            },
            childCount: value.length,
          ),
        );
      },
      valueListenable: _homeController.linksListNotifier,
    );
  }
}
