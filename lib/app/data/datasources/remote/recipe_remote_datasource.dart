import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exam_recipes_api/app/core/errors/failure.dart';
import 'package:exam_recipes_api/app/data/api/api.dart';

import '../../models/recipe_model/recipe_model.dart';

const ERROR_MSG = 'Something went wrong';

class RecipesRemoteDataSource {
  final RestClient client;
  RecipesRemoteDataSource({required this.client});

  /// get recipes from api endpoint
  /// return Failure if catch error or status code is not 200
  /// return decoded data as Map if status code is 200
  Future<Either<Failure, List<RecipeModel>>> getRecipes() async {
    try {
      final recipes = await client.getTopHeadlines();
      return Right(recipes);
    } on DioError catch (error) {
      print(error.type);
      print(error.message);
      return Left(Failure(error.message ?? ERROR_MSG));
    } on Exception catch (_) {
      return const Left(Failure(ERROR_MSG));
    }
  }
}
