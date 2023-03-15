import 'package:dartz/dartz.dart';

import '../repositories/recipe_repository.dart';

import '../entities/recipe_entity.dart';

import 'package:exam_recipes_api/app/core/errors/failure.dart';
import 'package:exam_recipes_api/app/core/usecases/usecase.dart';

class GetLocalRecipes implements UseCase<List<RecipeEntity>, NoParams> {
  final RecipesRepository repository;
  GetLocalRecipes(this.repository);
  @override
  Future<Either<Failure, List<RecipeEntity>>> call(NoParams params) async {
    await Future.delayed(const Duration(seconds: 1));
    return repository.getLocalRecipes();
  }
}
