import 'package:exam_recipes_api/app/data/datasources/local/hive/recipe.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
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

  const RecipeModel({
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
  String toString() {
    return 'RecipeModel(calories: $calories, carbos: $carbos, description: $description, difficulty: $difficulty, fats: $fats, headline: $headline, id: $id, image: $image, name: $name, proteins: $proteins, thumb: $thumb, time: $time)';
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return _$RecipeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);

  RecipeModel copyWith({
    String? calories,
    String? carbos,
    String? description,
    int? difficulty,
    String? fats,
    String? headline,
    String? id,
    String? image,
    String? name,
    String? proteins,
    String? thumb,
    String? time,
  }) {
    return RecipeModel(
      calories: calories ?? this.calories,
      carbos: carbos ?? this.carbos,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      fats: fats ?? this.fats,
      headline: headline ?? this.headline,
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      proteins: proteins ?? this.proteins,
      thumb: thumb ?? this.thumb,
      time: time ?? this.time,
    );
  }

  factory RecipeModel.fromRecipeDB(Recipe recipe) {
    return RecipeModel(
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
