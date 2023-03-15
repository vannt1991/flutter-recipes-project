import 'dart:async';

import '../../../models/recipe_model/recipe_model.dart';
import '../recipe_local_datasource.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class RecipesLocalDataSourceSembastImpl implements RecipesLocalDataSource {
  // Name constants
  final _kDbFileName = 'sembast_recipes.db';
  final _kRecipesStoreName = 'recipes_store';

  // Sembast database object
  late Database _database;

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are RecipeModel objects converted to Map
  late StoreRef<int, Map<String, dynamic>> _recipesStore;

  // initialize database
  @override
  Future<bool> initDb() async {
    try {
      // Get a platform-specific directory where persistent app data can be stored
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _kDbFileName);
      _database = await databaseFactoryIo.openDatabase(dbPath);
      _recipesStore = intMapStoreFactory.store(_kRecipesStoreName);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// delete database
  @override
  Future<bool> deleteDb() async {
    try {
      // Get a platform-specific directory where persistent app data can be stored
      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _kDbFileName);
      await databaseFactoryIo.deleteDatabase(dbPath);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// save recipes in database
  @override
  Future<bool> insertRecipes(List<RecipeModel> recipes) async {
    try {
      // delete all recipes from store
      await _recipesStore.delete(_database);

      // insert all recipes to  store
      for (final recipe in recipes) {
        await _recipesStore.add(_database, recipe.toJson());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  /// return all stored recipes
  @override
  Future<List<RecipeModel>?> getRecipes() async {
    try {
      final recordSnapshots = await _recipesStore.find(_database);
      return recordSnapshots
          .map((snapshot) => RecipeModel.fromJson(snapshot.value))
          .toList();
    } catch (e) {
      return null;
    }
  }

  /// delete all recipes records
  @override
  Future<bool> deleteAllRecipes() async {
    try {
      await _recipesStore.delete(_database);
      return true;
    } catch (e) {
      return false;
    }
  }
}
