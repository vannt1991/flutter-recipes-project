import 'package:equatable/equatable.dart';
import 'package:exam_recipes_api/app/data/models/recipe_model/recipe_model.dart';

import '../../data/datasources/local/hive/recipe.dart';

class RecipeEntity extends Equatable {
  final String? calories;
  final String? carbos;
  final String? description;
  final int? difficulty;
  final String? fats;
  final String? headline;
  final String? id;
  final String? image;
  final String? name;
  final String? proteins;
  final String? thumb;
  final String? time;

  const RecipeEntity({
    this.calories,
    this.carbos,
    this.description,
    this.difficulty,
    this.fats,
    this.headline,
    this.id,
    this.image,
    this.name,
    this.proteins,
    this.thumb,
    this.time,
  });

  @override
  List<dynamic> get props => [
        calories,
        carbos,
        description,
        difficulty,
        fats,
        headline,
        id,
        image,
        name,
        proteins,
        thumb,
        time,
      ];

  factory RecipeEntity.fromRecipeModel(RecipeModel recipe) {
    return RecipeEntity(
      calories: recipe.calories,
      carbos: recipe.carbos,
      description: recipe.description,
      difficulty: recipe.difficulty,
      fats: recipe.fats,
      headline: recipe.headline,
      id: recipe.id,
      image: recipe.image,
      name: recipe.name,
      proteins: recipe.proteins,
      thumb: recipe.thumb,
      time: recipe.time,
    );
  }

  factory RecipeEntity.fromRecipeDB(Recipe recipe) {
    return RecipeEntity(
      calories: recipe.calories,
      carbos: recipe.carbos,
      description: recipe.description,
      difficulty: recipe.difficulty,
      fats: recipe.fats,
      headline: recipe.headline,
      id: recipe.id,
      image: recipe.image,
      name: recipe.name,
      proteins: recipe.proteins,
      thumb: recipe.thumb,
      time: recipe.time,
    );
  }

  RecipeModel toRecipeModel() {
    return RecipeModel(
      calories: this.calories,
      carbos: this.carbos,
      description: this.description,
      difficulty: this.difficulty,
      fats: this.fats,
      headline: this.headline,
      id: this.id,
      image: this.image,
      name: this.name,
      proteins: this.proteins,
      thumb: this.thumb,
      time: this.time,
    );
  }

  Recipe toRecipeDB() {
    return Recipe(
      calories: this.calories,
      carbos: this.carbos,
      description: this.description,
      difficulty: this.difficulty,
      fats: this.fats,
      headline: this.headline,
      id: this.id,
      image: this.image,
      name: this.name,
      proteins: this.proteins,
      thumb: this.thumb,
      time: this.time,
    );
  }
}
