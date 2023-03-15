import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(adapterName: 'RecipeAdapter', typeId: 0)
class Recipe {
  @HiveField(0)
  final String? calories;
  @HiveField(1)
  final String? carbos;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final int? difficulty;
  @HiveField(4)
  final String? fats;
  @HiveField(5)
  final String? headline;
  @HiveField(6)
  final String? id;
  @HiveField(7)
  final String? image;
  @HiveField(8)
  final String? name;
  @HiveField(9)
  final String? proteins;
  @HiveField(10)
  final String? thumb;
  @HiveField(11)
  final String? time;

  const Recipe({
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
}
