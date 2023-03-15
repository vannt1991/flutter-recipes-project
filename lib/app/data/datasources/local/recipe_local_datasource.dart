import '../../models/recipe_model/recipe_model.dart';

abstract class RecipesLocalDataSource {
  Future<bool> initDb();
  Future<bool> deleteDb();
  Future<bool> insertRecipes(List<RecipeModel> recipes);
  Future<bool> deleteAllRecipes();
  Future<List<RecipeModel>?> getRecipes();
}
