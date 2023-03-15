import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_recipes_api/di/injector.dart';

import '../../../core/widgets/index.dart' as core_widgets;

import '../controller/index.dart';
import '../widgets/widgets.dart';

class HomeViewCubit extends StatelessWidget {
  const HomeViewCubit({super.key});

  PreferredSizeWidget appBar() {
    return AppBar(
      elevation: 8.0,
      // backgroundColor: Colors.yellow,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.adb,
            color: Colors.black,
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(
            'Recipes',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ).paddingAll(4.0),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder<RecipesCubit, RecipesState>(
      builder: (context, state) {
        return state.when(
          initial: () => const core_widgets.LoadingWidget(),
          loading: () => const core_widgets.LoadingWidget(),
          success: (recipes) => RecipesView(recipes: recipes),
          error: (failure) => core_widgets.ErrorWidget(message: failure.message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (_) => Injector.resolve<RecipesCubit>()..getRecipes(),
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
