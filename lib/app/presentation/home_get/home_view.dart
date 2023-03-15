import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../l10n/gen/app_localizations.dart';
import '../widgets/language_widget.dart';
import 'home_controller.dart';

import '../../core/widgets/index.dart' as core_widgets;
import 'widgets/widgets.dart';

class HomeViewGetX extends GetView<HomeController> {
  const HomeViewGetX({super.key});

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 8.0,
      // backgroundColor: Colors.yellow,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.adb,
            color: Colors.black,
          ),
          const SizedBox(
            width: 6.0,
          ),
          Builder(builder: (context) {
            return Text(
              AppLocalizations.of(context)!.titleHome,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            );
          }
          ),
        ],
      ).paddingAll(4.0),
      actions: [
        const LanguagePickerWidget(),
        const SizedBox(width: 12),
        ConnectivityIcon(controller: controller).paddingOnly(right: 10.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: Colors.yellow,
        appBar: appBar(),
        body: Obx(() {
          switch (controller.viewState.value) {
            case ViewState.busy:
              return const core_widgets.LoadingWidget();
            case ViewState.error:
              return const core_widgets.ErrorWidget();
            case ViewState.data:
              return RecipesView(
                recipes: controller.recipes,
                fetch: controller.remoteFetch,
              );
            default:
              return const core_widgets.LoadingWidget();
          }
        }),
        floatingActionButton: FAB(
          callback: controller.remoteFetch,
        ),
      ),
    );
  }
}
