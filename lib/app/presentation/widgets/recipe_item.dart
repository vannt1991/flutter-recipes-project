import 'package:exam_recipes_api/app/presentation/detail_screen.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/recipe_entity.dart';
import '../../core/widgets/index.dart' as core_widgets;

class RecipeItem extends StatelessWidget {
  final RecipeEntity recipe;
  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // for quickly we using dynamic navigator, for large project we navigation using name of router
        Navigator.of(context).push(MaterialPageRoute(
            builder: (builder) => DetailScreen(
                  recipe: recipe,
                )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: core_widgets.ImageHandlerWidget(
                urlToImage: recipe.thumb ?? '',
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          recipe.name ?? '--',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(recipe.time ?? '--',
                          style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfo('Calories', recipe.calories ?? '--'),
                      _buildInfo('Proteins', recipe.proteins ?? '--'),
                      _buildInfo('Fats', recipe.fats ?? '--'),
                      _buildInfo('Carbos', recipe.carbos ?? '--'),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Column _buildInfo(String name, String value) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(
          value,
        ),
      ],
    );
  }
}
