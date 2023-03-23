import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/recipe_model/recipe_model.dart';

part 'api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/android-test/recipes.json")
  Future<List<RecipeModel>> getTopHeadlines();
}
