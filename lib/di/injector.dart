import 'package:kiwi/kiwi.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import '../app/data/api/api.dart';
import '../app/data/datasources/local/recipe_local_datasource.dart';
import '../app/data/datasources/local/sembast/recipe_local_datasource_sembast.dart';
import '../app/data/datasources/local/sqflite/recipe_local_datasource_sqlite.dart';
import '../app/data/datasources/remote/recipe_remote_datasource.dart';

import '../app/data/datasources/local/hive/recipe_local_datasource_hive.dart';

import '../app/data/repositories/recipe_repository_impl.dart';
import '../app/domain/repositories/recipe_repository.dart';

import '../app/domain/usecases/get_local_recipe.dart';
import '../app/domain/usecases/get_remote_recipe.dart';

import '../app/core/network/network_info.dart';

import '../app/presentation/home_bloc/controller/index.dart';
import '../app/presentation/home_cubit/controller/index.dart';

part 'injector.g.dart';

abstract class Injector {
  static late KiwiContainer container;

  static void setup() {
    container = KiwiContainer();
    _$Injector()._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureCore();
    _configureRecipesFeatureModule();
  }

  // Core module
  @Register.singleton(Connectivity)
  @Register.singleton(NetworkInfoI, from: NetworkInfo)
  void _configureCore();

  // Recipes Feature module
  void _configureRecipesFeatureModule() {
    _configureRecipesFeatureModuleInstances();
    _configureRecipesFeatureModuleFactories();
  }

  // Recipes Feature module instances
  void _configureRecipesFeatureModuleInstances() {
    container.registerInstance(RestClient(
        Dio(BaseOptions(contentType: "application/json")),
        baseUrl: dotenv.env['BASE_URL']!));
  }

  // Recipes Feature module factories
  @Register.singleton(RecipesRemoteDataSource)
  @Register.singleton(RecipesLocalDataSource,
      from: RecipesLocalDataSourceSqlImpl)
  @Register.singleton(GetLocalRecipes)
  @Register.singleton(GetRemoteRecipes)
  @Register.singleton(RecipesRepository, from: RecipesRepositoryImpl)
  @Register.factory(RecipesCubit)
  @Register.factory(RecipesBloc)
  void _configureRecipesFeatureModuleFactories();
}
