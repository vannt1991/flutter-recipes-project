// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureCore() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton((c) => Connectivity())
      ..registerSingleton<NetworkInfoI>(
          (c) => NetworkInfo(connectivity: c<Connectivity>()));
  }

  @override
  void _configureRecipesFeatureModuleFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerSingleton(
          (c) => RecipesRemoteDataSource(client: c<RestClient>()))
      ..registerSingleton<RecipesLocalDataSource>(
          (c) => RecipesLocalDataSourceHiveImpl())
      ..registerSingleton((c) => GetLocalRecipes(c<RecipesRepository>()))
      ..registerSingleton((c) => GetRemoteRecipes(c<RecipesRepository>()))
      ..registerSingleton<RecipesRepository>((c) => RecipesRepositoryImpl(
          localDataSource: c<RecipesLocalDataSource>(),
          remoteDataSource: c<RecipesRemoteDataSource>()))
      ..registerFactory((c) => RecipesCubit(
          c<NetworkInfoI>(), c<GetRemoteRecipes>(), c<GetLocalRecipes>()))
      ..registerFactory((c) => LocaleCubit())
      ..registerFactory((c) => RecipesBloc(
          c<NetworkInfoI>(), c<GetRemoteRecipes>(), c<GetLocalRecipes>()));
  }
}
