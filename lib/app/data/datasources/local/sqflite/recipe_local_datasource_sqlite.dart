import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../models/recipe_model/recipe_model.dart';
import '../recipe_local_datasource.dart';

class RecipesLocalDataSourceSqlImpl implements RecipesLocalDataSource {
  final _kDbFileName = 'sqflite_ex.db';
  final _kDBTableName = 'recipes_table';
  Database? _db;

  /// Opens a db local file. Creates the db table if it's not yet created.
  @override
  Future<bool> initDb() async {
    try {
      // get database path directory
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, _kDbFileName);
      // open db
      _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await _initRecipesTable(db);
        },
      );
      // success init db
      return true;
    } on DatabaseException catch (e) {
      // failed to init db
      print(e);
      return false;
    }
  }

  /// delete the database
  @override
  Future<bool> deleteDb() async {
    try {
      final dbFolder = await getDatabasesPath();
      if (!await Directory(dbFolder).exists()) {
        await Directory(dbFolder).create(recursive: true);
      }
      final dbPath = join(dbFolder, _kDbFileName);
      await deleteDatabase(dbPath);
      _db = null;
      return true;
    } catch (_) {
      return false;
    }
  }

  // creates recipes table
  Future<void> _initRecipesTable(Database db) async {
    await db.execute('''
          CREATE TABLE $_kDBTableName(
          id INTEGER PRIMARY KEY,
          calories TEXT,
          carbos TEXT,
          description TEXT,
          difficulty int,
          fats TEXT,
          headline TEXT,
          image TEXT,
          name TEXT,
          proteins TEXT,
          thumb TEXT,
          time TEXT,
          )
        ''');
  }

  /// save recipes
  @override
  Future<bool> insertRecipes(List<RecipeModel> recipes) async {
    if (recipes == null || recipes.isEmpty) return false;
    await deleteAllRecipes();
    final validatedRecipes = validateData(recipes);
    try {
      for (final recipe in validatedRecipes) {
        await _db?.transaction(
          (txn) async {
            await txn.rawInsert('''
          INSERT INTO $_kDBTableName
          (
          calories,
          carbos,
          description,
          difficulty,
          fats,
          headline,
          id,
          image,
          name,
          proteins,
          thumb,
          time,
          )
          VALUES
            (
              "${recipe.calories}",
              "${recipe.carbos}",
              "${recipe.description}",
              "${recipe.difficulty}",
              "${recipe.fats}",
              "${recipe.headline}",
              "${recipe.id}",
              "${recipe.image}",
              "${recipe.name}",
              "${recipe.proteins}",
              "${recipe.thumb}",
              "${recipe.time}",
            )''');
          },
        );
      }
      // success inserted data
      return true;
    } on DatabaseException catch (e) {
      // failed to insert data
      print(e);
      return false;
    }
  }

  /// delete all recipes
  @override
  Future<bool> deleteAllRecipes() async {
    try {
      await _db?.rawDelete('''
        DELETE FROM $_kDBTableName
      ''');
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  /// get all saved recipes from db
  @override
  Future<List<RecipeModel>?> getRecipes() async {
    final jsons = await _db?.rawQuery('SELECT * FROM $_kDBTableName');
    return jsons?.map((e) => RecipeModel.fromJson(e)).toList();
  }

  /// validate Recipes data to evoid database exception
  List<RecipeModel> validateData(List<RecipeModel> recipes) {
    final validRecipes = <RecipeModel>[];
    for (final recipe in recipes) {
      final validTitle = recipe.name?.replaceAll('"', "'");
      final validContent = recipe.description?.replaceAll('"', "'");
      final validRecipe =
          recipe.copyWith(name: validTitle, description: validContent);
      validRecipes.add(validRecipe);
    }
    return validRecipes;
  }
}
