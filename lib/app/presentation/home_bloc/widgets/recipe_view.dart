import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/widgets/index.dart' as core_widgets;
import '../../../domain/entities/recipe_entity.dart';
import '../../widgets/recipe_item.dart';
import '../controller/index.dart';

class RecipesView extends StatelessWidget {
  final List<RecipeEntity> recipes;
  const RecipesView({super.key, required this.recipes});

  Widget buildRecipeTile(RecipeEntity recipe) {
    // final formattedTime =
    //     DateFormat('dd MMM - HH:mm').format(recipe.publishedAt);
    return Row(
      children: [
        core_widgets.ImageHandlerWidget(
          urlToImage: recipe.image ?? '',
        ),
        const SizedBox(
          width: 16.0,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(recipe.calories ?? ''),
              Text(
                recipe.name ?? '',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                recipe.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    ).paddingAll(5.0);
  }

  @override
  Widget build(BuildContext context) {
    if (recipes.isEmpty) {
      return const core_widgets.ErrorWidget(
        message: 'Can not find recipes :(',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<RecipesBloc>(context).add(const RecipesEvent.getData());
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ListView.separated(
          key: const ValueKey('recipes_list'),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            return RecipeItem(
              key: ValueKey('recipe$index'),
              recipe: recipe,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
