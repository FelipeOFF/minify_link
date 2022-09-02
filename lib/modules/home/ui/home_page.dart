import 'package:flutter/material.dart';
import 'package:minify_link/commons/base/base_state_page.dart';
import 'package:minify_link/commons/dialog/common_dialog.dart';
import 'package:minify_link/modules/home/components/custom_section_sliver.dart';
import 'package:minify_link/modules/home/components/custom_sliver_app_bar.dart';
import 'package:minify_link/modules/home/components/list_of_links.dart';
import 'package:minify_link/modules/home/controller/home_controller.dart';
import 'package:minify_link/res/strings/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseStatePage<HomePage, HomeController> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.linkShortenedNotifier.addListener(openDialogToShowShortenedLink);
  }

  @override
  void dispose() {
    controller.linkShortenedNotifier
        .removeListener(openDialogToShowShortenedLink);
    super.dispose();
  }

  Future<void> openDialogToShowShortenedLink() async {
    final linkShortened = controller.linkShortened;
    if (linkShortened != null) {
      await createInformativeDialogForShowLink(linkShortened, context)
          .showBottomSheetDialog(context);
      controller.linkShortened = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBar(formKey: _formKey),
            const CustomSectionSliver(text: Strings.recentlyShortenedURLs),
            ListOfLinks(),
          ],
        ),
      ),
    );
  }
}
