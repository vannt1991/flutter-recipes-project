import 'package:dartz/dartz.dart';

import '../repositories/recipe_repository.dart';

import '../entities/recipe_entity.dart';

import 'package:exam_recipes_api/app/core/errors/failure.dart';
import 'package:exam_recipes_api/app/core/usecases/usecase.dart';

class GetRemoteRecipes implements UseCase<List<RecipeEntity>, NoParams> {
  final RecipesRepository repository;
  GetRemoteRecipes(this.repository);
  @override
  Future<Either<Failure, List<RecipeEntity>>> call(NoParams params) async {
    return repository.getRemoteRecipes();
  }
}
