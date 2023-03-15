import '../models/recipe_model/recipe_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/android-test/recipes.json")
  Future<List<RecipeModel>> getTopHeadlines();
}
