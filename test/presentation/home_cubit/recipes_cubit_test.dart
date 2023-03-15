import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:exam_recipes_api/app/core/errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exam_recipes_api/app/core/usecases/usecase.dart';

import 'package:exam_recipes_api/app/domain/usecases/get_local_recipe.dart';
import 'package:exam_recipes_api/app/domain/usecases/get_remote_recipe.dart';

import 'package:exam_recipes_api/app/core/network/network_info.dart';
import 'package:exam_recipes_api/app/presentation/home_cubit/controller/index.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_helper.dart';
import 'recipes_cubit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NetworkInfoI>(),
  MockSpec<GetRemoteRecipes>(),
  MockSpec<GetLocalRecipes>()
])
void main() {
  late NetworkInfoI networkInfo;
  late GetRemoteRecipes getRemoteRecipes;
  late GetLocalRecipes getLocalRecipes;
  late RecipesCubit recipesCubit;

  setUp(() {
    networkInfo = MockNetworkInfoI();
    getRemoteRecipes = MockGetRemoteRecipes();
    getLocalRecipes = MockGetLocalRecipes();
    recipesCubit = RecipesCubit(networkInfo, getRemoteRecipes, getLocalRecipes);
  });

  group('is online', () {
    blocTest<RecipesCubit, RecipesState>(
      'should emits [Loading, Success] when cubit.getRecipes is called succesfuly.',
      build: () {
        when(networkInfo.isConnected())
            .thenAnswer((realInvocation) => Future.value(true));
        when(getRemoteRecipes.call(NoParams()))
            .thenAnswer((realInvocation) => Future.value(Right(recipes)));
        return recipesCubit;
      },
      act: (cubit) => cubit.getRecipes(),
      expect: () => [isA<Loading>(), Success(recipes)],
      verify: (_) {
        verifyInOrder(
            [networkInfo.isConnected(), getRemoteRecipes.call(NoParams())]);
        verifyNoMoreInteractions(networkInfo);
        verifyNoMoreInteractions(getRemoteRecipes);
        verifyZeroInteractions(getLocalRecipes);
      },
    );
  });

  group('is offline', () {
    blocTest<RecipesCubit, RecipesState>(
      'should emits [Loading, Success] when cubit.getRecipes is called succesfuly.',
      build: () {
        when(networkInfo.isConnected())
            .thenAnswer((realInvocation) => Future.value(false));
        when(networkInfo.onConnectivityChanged).thenAnswer(
            (realInvocation) => Stream.fromIterable([ConnectivityResult.none]));
        when(getLocalRecipes.call(NoParams()))
            .thenAnswer((realInvocation) => Future.value(Right(recipes)));
        return recipesCubit;
      },
      act: (cubit) => cubit.getRecipes(),
      expect: () => [
        const RecipesState.loading(),
        const RecipesState.error(Failure('There is no internet connection')),
        Success(recipes)
      ],
      verify: (_) {
        verifyInOrder([
          networkInfo.isConnected(),
          getLocalRecipes.call(NoParams()),
          networkInfo.onConnectivityChanged
        ]);
        verifyNoMoreInteractions(networkInfo);
        verifyNoMoreInteractions(getLocalRecipes);
        verifyZeroInteractions(getRemoteRecipes);
      },
    );
  });
}
