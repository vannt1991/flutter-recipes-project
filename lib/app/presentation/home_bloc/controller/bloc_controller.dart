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
import 'event.dart';
import 'state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  // construct bloc with initial state
  RecipesBloc(this.network, this.getRemoteRecipes, this.getLocalRecipes)
      : super(const Initial()) {
    on<GetData>(mapEventToState);
  }

  // dependencies
  final NetworkInfoI network;
  final GetRemoteRecipes getRemoteRecipes;
  final GetLocalRecipes getLocalRecipes;

  void mapEventToState(
      RecipesEvent event, Emitter<RecipesState> emitter) async {
    // handle GetData event
    print('mapEventToState $event');
    if (event is GetData) {
      emitter(const RecipesState.loading());
      // check for network connection
      final connectivity = await network.isConnected();
      Either<Failure, List<RecipeEntity>> failureOrRecipes;
      if (connectivity) {
        failureOrRecipes = await getRemoteRecipes.call(NoParams());
      } else {
        failureOrRecipes = await getLocalRecipes.call(NoParams());
        waitForConnectivityAndNotifyGetDataEvent();
        emitter(
            const RecipesState.error(Failure('There is no internet connection')));
        // Get.snackbar('Offline mode', 'There is no internet connection',
        //       snackPosition: SnackPosition.BOTTOM);
      }
      // yield new RecipesState
      emitter(failureOrRecipes.fold(
          (failure) => Error(failure), (recipes) => Success(recipes)));
    }
  }

  void waitForConnectivityAndNotifyGetDataEvent() {
    StreamSubscription? subscription;
    subscription = network.onConnectivityChanged.listen((event) {
      if (event != ConnectivityResult.none) {
        subscription?.cancel();
        add(const RecipesEvent.getData());
      }
    });
  }
}
