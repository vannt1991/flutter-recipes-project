import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../di/injector.dart';
import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/usecases/get_local_recipe.dart';
import '../../domain/usecases/get_remote_recipe.dart';

part 'recipes_future.g.dart';

@riverpod
Future<List<RecipeEntity>?> recipes(
  RecipesRef ref, {
  required int movieId,
}) async {
  // final cancelToken = ref.cancelToken();
  // return ref
  //     .watch(moviesRepositoryProvider)
  //     .movie(movieId: movieId, cancelToken: cancelToken);
  final NetworkInfoI network = Injector.resolve<NetworkInfoI>();
  final GetRemoteRecipes getRemoteRecipes =
      Injector.resolve<GetRemoteRecipes>();
  final GetLocalRecipes getLocalRecipes = Injector.resolve<GetLocalRecipes>();

  final connectivity = await network.isConnected();
  Either<Failure, List<RecipeEntity>> failureOrRecipes;
  if (connectivity) {
    failureOrRecipes = await getRemoteRecipes.call(NoParams());
  } else {
    failureOrRecipes = await getLocalRecipes.call(NoParams());
    throw const Failure('There is no internet connection');
  }
  // yield new RecipesState
  return (failureOrRecipes.fold(
      (failure) => throw failure, (recipes) => recipes));
}
