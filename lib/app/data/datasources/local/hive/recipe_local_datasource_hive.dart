import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

import '../recipe_local_datasource.dart';
import '../../../models/recipe_model/recipe_model.dart';
import 'recipe.dart';

class RecipesLocalDataSourceHiveImpl implements RecipesLocalDataSource {
  final _kRecipesBoxName = 'recipes_box';

  @override
  Future<bool> initDb() async {
    try {
      if (!foundation.kIsWeb) {
        final appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }

      Hive.registerAdapter(RecipeAdapter());
      await Hive.openBox<Recipe>(_kRecipesBoxName);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteDb() async {
    // TODO: implement deleteDb
    throw UnimplementedError();
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    // return recipes hive box
    final recipesBox = Hive.box<Recipe>(_kRecipesBoxName);
    return recipesBox.values.map<RecipeModel>((e) {
      return RecipeModel.fromRecipeDB(e);
    }).toList();
  }

  @override
  Future<bool> insertRecipes(List<RecipeModel> recipes) async {
    try {
      // return recipes hive box
      final recipesBox = Hive.box<Recipe>(_kRecipesBoxName);
      // clear all enrties from hive box
      final deleted = await recipesBox.clear();
      // print deleted entries
      print('delete $deleted entries from hive $_kRecipesBoxName box');
      // convert RecipeModel to HiveType Recipe
      final converted = recipes.map((e) => e.toRecipeDB()).toList();
      // insert all recipes to hive box
      final entries = await recipesBox.addAll(converted);
      print(entries);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> deleteAllRecipes() async {
    try {
      // return recipes hive box
      final recipesBox = Hive.box<Recipe>(_kRecipesBoxName);
      // clear all enrties from hive box
      final deleted = await recipesBox.clear();
      // print deleted entries
      print('delete $deleted entries from hive $_kRecipesBoxName box');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}
