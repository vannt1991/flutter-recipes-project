import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/index.dart' as core_widgets;
import '../controller/index.dart';
import '../widgets/widgets.dart';

class HomeViewRiverPod extends ConsumerStatefulWidget {
  const HomeViewRiverPod({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DepartmentCreateFormState();
}

class _DepartmentCreateFormState extends ConsumerState<HomeViewRiverPod> {
  @override
  void initState() {
    super.initState();

    // final value = ref.read(helloWorldProvider);
    // print(value); // Hello world
    ref.read(homeControllerProvider.notifier).getData();
  }

  Widget buildBody(BuildContext context) {
    final res = ref.watch(homeControllerProvider);
    final errorText = res.maybeWhen(
      error: (error, stackTrace) => error.toString(),
      orElse: () => null,
    );

    if (errorText?.isNotEmpty == true) {
      return core_widgets.ErrorWidget(message: errorText);
    }

    final isLoading = res.maybeWhen(
      data: (_) => res.isRefreshing,
      loading: () => true,
      orElse: () => false,
    );
    if (isLoading) {
      return const core_widgets.LoadingWidget();
    }

    return RecipesView(recipes: res.asData?.value ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        // backgroundColor: Colors.yellow,
        appBar: appBar(),
        body: buildBody(context),
        floatingActionButton: const FAB(),
      ),
    );
  }
}
