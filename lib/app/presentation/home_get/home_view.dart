import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/app_bar.dart';
import '../../core/widgets/index.dart' as core_widgets;
import '../widgets/language_widget.dart';
import 'home_controller.dart';
import 'widgets/widgets.dart';

class HomeViewGetX extends GetView<HomeController> {
  const HomeViewGetX({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: Colors.yellow,
        appBar: appBar(moreActions: [
          const LanguagePickerWidget(),
          const SizedBox(width: 12),
          ConnectivityIcon(controller: controller).paddingOnly(right: 10.0)
        ]),
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
