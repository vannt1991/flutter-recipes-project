import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';

import 'package:exam_recipes_api/app/data/api/api.dart';
import 'package:exam_recipes_api/app/data/models/recipe_model/recipe_model.dart';
import 'package:exam_recipes_api/app/data/datasources/remote/recipe_remote_datasource.dart';


class MockRestClient extends Mock implements RestClient {
  @override
  Future<List<RecipeModel>> getTopHeadlines() => (super.noSuchMethod(
        Invocation.method(
          #getTopHeadlines,
          [],
        ),
        returnValue: Future<List<RecipeModel>>.value(<RecipeModel>[]),
      ) as Future<List<RecipeModel>>);
}

void main() {
  late RestClient client;
  late RecipesRemoteDataSource remoteDataSource;
  setUp(() {
    client = MockRestClient();
    remoteDataSource = RecipesRemoteDataSource(client: client);
  });

  const recipes = <RecipeModel>[
    RecipeModel(name: 'test', description: 'test', image: 'url', thumb: 'url')
  ];

  test('should return recipes data when the call to rest client is successful',
      () async {
    // arrange
    when(client.getTopHeadlines())
        .thenAnswer((realInvocation) => Future.value(recipes));

    // act
    final result = await remoteDataSource.getRecipes();

    // assert
    expect(result, const Right(recipes));
    verify(client.getTopHeadlines());
    verifyNoMoreInteractions(client);
  });

  test('should return failure when the call to rest client ends with Exception',
      () async {
    // arrange
    when(client.getTopHeadlines()).thenThrow(Exception());

    // act
    final result = await remoteDataSource.getRecipes();

    // assert
    expect(result, isA<Left>());
    verify(client.getTopHeadlines());
    verifyNoMoreInteractions(client);
  });
}
