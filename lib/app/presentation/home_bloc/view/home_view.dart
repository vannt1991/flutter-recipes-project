import 'package:exam_recipes_api/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/index.dart' as core_widgets;
import '../controller/index.dart';
import '../widgets/widgets.dart';

class HomeViewBloc extends StatelessWidget {
  const HomeViewBloc({super.key});

  Widget buildBody(BuildContext context) {
    return BlocBuilder<RecipesBloc, RecipesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const core_widgets.LoadingWidget(),
          loading: () => const core_widgets.LoadingWidget(),
          success: (recipes) => RecipesView(recipes: recipes),
          error: (failure) =>
              core_widgets.ErrorWidget(message: failure.message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (_) =>
            Injector.resolve<RecipesBloc>()..add(const RecipesEvent.getData()),
        child: Scaffold(
          // backgroundColor: Colors.yellow,
          appBar: appBar(),
          body: buildBody(context),
          floatingActionButton: const FAB(),
        ),
      ),
    );
  }
}
