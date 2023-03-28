import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../di/injector.dart';
import '../../../core/errors/failure.dart';
import '../../../core/network/network_info.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/recipe_entity.dart';
import '../../../domain/usecases/get_local_recipe.dart';
import '../../../domain/usecases/get_remote_recipe.dart';

final homeControllerProviderAsync = AsyncNotifierProvider.autoDispose<
    HomeRiverPodControllerAsync, List<RecipeEntity>?>(() {
  return Injector.resolve<HomeRiverPodControllerAsync>();
});

class HomeRiverPodControllerAsync
    extends AutoDisposeAsyncNotifier<List<RecipeEntity>?> {
  // construct bloc with initial state
  HomeRiverPodControllerAsync(
      this.network, this.getRemoteRecipes, this.getLocalRecipes)
      : super();

  // dependencies
  final NetworkInfoI network;
  final GetRemoteRecipes getRemoteRecipes;
  final GetLocalRecipes getLocalRecipes;

  void getData() async {
    // handle GetData event
    print('getData');
    state = const AsyncValue.loading();
    // check for network connection
    final connectivity = await network.isConnected();
    Either<Failure, List<RecipeEntity>> failureOrRecipes;
    if (connectivity) {
      failureOrRecipes = await getRemoteRecipes.call(NoParams());
    } else {
      failureOrRecipes = await getLocalRecipes.call(NoParams());
      waitForConnectivityAndNotifyGetDataEvent();
      state = AsyncError(
          const Failure('There is no internet connection'), StackTrace.current);
    }
    // yield new RecipesState
    state = (failureOrRecipes.fold(
        (failure) => AsyncValue.error(failure, StackTrace.current),
        (recipes) => AsyncValue.data(recipes)));
  }

  void waitForConnectivityAndNotifyGetDataEvent() {
    StreamSubscription? subscription;
    subscription = network.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        subscription?.cancel();
        getData();
      }
    });
  }

  @override
  FutureOr<List<RecipeEntity>?> build() {
    return _getRecipes();
  }

  FutureOr<List<RecipeEntity>?>? _getRecipes() async {
    final connectivity = await network.isConnected();
    Either<Failure, List<RecipeEntity>> failureOrRecipes;
    if (connectivity) {
      failureOrRecipes = await getRemoteRecipes.call(NoParams());
    } else {
      failureOrRecipes = await getLocalRecipes.call(NoParams());
      waitForConnectivityAndNotifyGetDataEvent();
      throw const Failure('There is no internet connection');
    }
    // yield new RecipesState
    return (failureOrRecipes.fold(
        (failure) => throw failure, (recipes) => recipes));
  }
}
