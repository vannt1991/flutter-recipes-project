import 'package:dartz/dartz.dart';
import '../entities/recipe_entity.dart';
import 'package:exam_recipes_api/app/core/errors/failure.dart';

abstract class RecipesRepository {
  Future<Either<Failure, List<RecipeEntity>>> getRemoteRecipes();
  Future<Either<Failure, List<RecipeEntity>>> getLocalRecipes();
}
