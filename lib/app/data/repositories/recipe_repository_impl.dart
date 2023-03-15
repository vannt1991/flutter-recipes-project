import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/local/recipe_local_datasource.dart';
import '../datasources/remote/recipe_remote_datasource.dart';

class RecipesRepositoryImpl implements RecipesRepository {
  RecipesRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});
  // local data source
  final RecipesLocalDataSource localDataSource;
  // remote data source
  final RecipesRemoteDataSource remoteDataSource;

  /// return either failure or list of recipes
  @override
  Future<Either<Failure, List<RecipeEntity>>> getRemoteRecipes() async {
    try {
      final response = await remoteDataSource.getRecipes();
      return response.fold((failure) => Left(failure), (recipes) async {
        if (recipes != null && recipes.isNotEmpty) {
          await localDataSource.insertRecipes(recipes);
          return Right(
              recipes.map((e) => RecipeEntity.fromRecipeModel(e)).toList());
        }
        return const Left(Failure('Can not find recipes right now'));
      });
    } on Exception catch (_) {
      return const Left(Failure('Something went wrong'));
    }
  }

  /// return either failure or list of recipes from saved local database
  @override
  Future<Either<Failure, List<RecipeEntity>>> getLocalRecipes() async {
    final recipes = await localDataSource.getRecipes();
    if (recipes == null || recipes.isEmpty) {
      return const Left(Failure('No internet connection'));
    }
    return Right(recipes.map((e) => RecipeEntity.fromRecipeModel(e)).toList());
  }
}
