import 'package:exam_recipes_api/app/core/usecases/usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:exam_recipes_api/app/core/errors/failure.dart';

import 'package:exam_recipes_api/app/domain/repositories/recipe_repository.dart';
import 'package:exam_recipes_api/app/domain/usecases/get_local_recipe.dart';

import '../../test_helper.dart';

import 'get_local_recipes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RecipesRepository>()])
void main() {
  late GetLocalRecipes usecase;
  late RecipesRepository recipesRepositoryMock;

  setUp(() {
    recipesRepositoryMock = MockRecipesRepository();
    usecase = GetLocalRecipes(recipesRepositoryMock);
  });

  test('should get local recipes from the repository', () async {
    // arrange
    when(recipesRepositoryMock.getLocalRecipes())
        .thenAnswer((realInvocation) => Future.value(Right(recipes)));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, Right(recipes));
    verify(recipesRepositoryMock.getLocalRecipes());
    verifyNoMoreInteractions(recipesRepositoryMock);
  });

  test('should get failure from the repository', () async {
    const failure = Failure('something went wrong');
    // arrange
    when(recipesRepositoryMock.getLocalRecipes())
        .thenAnswer((realInvocation) => Future.value(const Left(failure)));

    // act
    final result = await usecase.call(NoParams());

    // assert
    expect(result, const Left(failure));
    verify(recipesRepositoryMock.getLocalRecipes());
    verifyNoMoreInteractions(recipesRepositoryMock);
  });
}
