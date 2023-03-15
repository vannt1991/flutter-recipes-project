import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../core/network/network_info.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/entities/recipe_entity.dart';
import '../../../domain/usecases/get_local_recipe.dart';
import '../../../domain/usecases/get_remote_recipe.dart';
import 'state.dart';

class RecipesCubit extends Cubit<RecipesState> {
  // construct bloc with initial state
  RecipesCubit(this.network, this.getRemoteRecipes, this.getLocalRecipes)
      : super(const Initial());

  // get dependencies
  final NetworkInfoI network;
  final GetRemoteRecipes getRemoteRecipes;
  final GetLocalRecipes getLocalRecipes;

  Future<void> getRecipes() async {
    emit(const Loading());
    final connectivity = await network.isConnected();
    Either<Failure, List<RecipeEntity>> failureOrRecipes;
    if (connectivity) {
      failureOrRecipes = await getRemoteRecipes.call(NoParams());
    } else {
      failureOrRecipes = await getLocalRecipes.call(NoParams());
      waitForConnectivityAndCallGetRecipes();
      emit(
          const RecipesState.error(Failure('There is no internet connection')));
      // Get.snackbar('Offline mode', 'There is no internet connection',
      //       snackPosition: SnackPosition.BOTTOM);
    }
    emit(failureOrRecipes.fold(
        (failure) => Error(failure), (recipes) => Success(recipes)));
  }

  void waitForConnectivityAndCallGetRecipes() {
    StreamSubscription? subscription;
    subscription = network.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        subscription?.cancel();
        getRecipes();
      }
    });
  }
}
