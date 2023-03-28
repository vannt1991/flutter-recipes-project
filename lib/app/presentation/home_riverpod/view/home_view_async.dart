import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/index.dart' as core_widgets;
import '../controller/index.dart';
import '../widgets/widgets.dart';

class HomeViewRiverPodAsync extends ConsumerStatefulWidget {
  const HomeViewRiverPodAsync({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DepartmentCreateFormState();
}

class _DepartmentCreateFormState extends ConsumerState<HomeViewRiverPodAsync> {
  @override
  void initState() {
    super.initState();

    // final value = ref.read(helloWorldProvider);
    // print(value); // Hello world
    // Future.microtask(
    //     () => ref.read(homeControllerProviderAsync.notifier).getData());
  }

  Widget buildBody(BuildContext context) {
    final res = ref.watch(homeControllerProviderAsync);
    final errorText = res.maybeWhen(
      error: (error, stackTrace) => error.toString(),
      orElse: () => null,
    );

    if (errorText?.isNotEmpty == true) {
      return core_widgets.ErrorWidget(message: errorText);
    }

    final isLoading = res.maybeWhen(
      data: (_) => res.isLoading || res.isRefreshing || res.isReloading,
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
        floatingActionButton: FAB(
          onPressed: () =>
              ref.read(homeControllerProviderAsync.notifier).getData(),
        ),
      ),
    );
  }
}
