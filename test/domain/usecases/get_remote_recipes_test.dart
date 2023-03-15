import 'package:exam_recipes_api/app/core/usecases/usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:exam_recipes_api/app/core/errors/failure.dart';

import 'package:exam_recipes_api/app/domain/usecases/get_remote_recipe.dart';
import 'package:exam_recipes_api/app/domain/repositories/recipe_repository.dart';

import '../../test_helper.dart';
import 'get_local_recipes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RecipesRepository>()])
void main() {
  late GetRemoteRecipes usecase;
  late RecipesRepository recipesRepositoryMock;

  setUp(() {
    recipesRepositoryMock = MockRecipesRepository();
    usecase = GetRemoteRecipes(recipesRepositoryMock);
  });

  test('should get remote recipes from the repository', () async {
    // arrange
    when(recipesRepositoryMock.getRemoteRecipes())
        .thenAnswer((realInvocation) => Future.value(const Right(recipes)));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, const Right(recipes));
    verify(recipesRepositoryMock.getRemoteRecipes());
    verifyNoMoreInteractions(MockRecipesRepository());
  });

  test('should get failure from the repository', () async {
    const failure = Failure('something went wrong');

    // arrange
    when(recipesRepositoryMock.getRemoteRecipes())
        .thenAnswer((realInvocation) => Future.value(const Left(failure)));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, const Left(failure));
    verify(recipesRepositoryMock.getRemoteRecipes());
    verifyNoMoreInteractions(MockRecipesRepository());
  });
}
