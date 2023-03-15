import 'package:dartz/dartz.dart';
import 'package:exam_recipes_api/app/core/errors/failure.dart';
import 'package:exam_recipes_api/app/data/datasources/local/recipe_local_datasource.dart';
import 'package:exam_recipes_api/app/data/datasources/remote/recipe_remote_datasource.dart';
import 'package:exam_recipes_api/app/data/models/recipe_model/recipe_model.dart';
import 'package:exam_recipes_api/app/data/repositories/recipe_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class _FakeEither_1<L, R> extends SmartFake implements Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class RecipesLocalDataSourceMock extends Mock
    implements RecipesLocalDataSource {
  @override
  Future<bool> insertRecipes(List<RecipeModel>? recipes) =>
      (super.noSuchMethod(
        Invocation.method(
          #insertRecipes,
          [recipes],
        ),
        returnValue: Future<bool>.value(false),
        returnValueForMissingStub: Future<bool>.value(false),
      ) as Future<bool>);
  @override
  Future<bool> deleteAllRecipes() => (super.noSuchMethod(
        Invocation.method(
          #deleteAllRecipes,
          [],
        ),
        returnValue: Future<bool>.value(false),
        returnValueForMissingStub: Future<bool>.value(false),
      ) as Future<bool>);
  @override
  Future<List<RecipeModel>?> getRecipes() => (super.noSuchMethod(
        Invocation.method(
          #getRecipes,
          [],
        ),
        returnValue: Future<List<RecipeModel>?>.value(),
        returnValueForMissingStub: Future<List<RecipeModel>?>.value(),
      ) as Future<List<RecipeModel>?>);
}

class RecipesRemoteDataSourceMock extends Mock
    implements RecipesRemoteDataSource {
  @override
  Future<Either<Failure, List<RecipeModel>>> getRecipes() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRecipes,
          [],
        ),
        returnValue: Future<Either<Failure, List<RecipeModel>>>.value(
            _FakeEither_1<Failure, List<RecipeModel>>(
          this,
          Invocation.method(
            #getRecipes,
            [],
          ),
        )),
        returnValueForMissingStub:
            Future<Either<Failure, List<RecipeModel>>>.value(
                _FakeEither_1<Failure, List<RecipeModel>>(
          this,
          Invocation.method(
            #getRecipes,
            [],
          ),
        )),
      ) as Future<Either<Failure, List<RecipeModel>>>);
}

void main() {
  late RecipesLocalDataSource localDataSource;
  late RecipesRemoteDataSource remoteDataSource;
  late RecipesRepositoryImpl repository;

  setUp(() {
    localDataSource = RecipesLocalDataSourceMock();
    remoteDataSource = RecipesRemoteDataSourceMock();
    repository = RecipesRepositoryImpl(
        localDataSource: localDataSource, remoteDataSource: remoteDataSource);
  });

  const recipes = <RecipeModel>[
    RecipeModel(name: 'test', description: 'test', image: 'url', thumb: 'url')
  ];
  group('remote recipes:', () {
    test(
        'should return recipes data when the call to remoteDataSource is successful, and insert recipes to localDataSource',
        () async {
      // arrange
      when(remoteDataSource.getRecipes())
          .thenAnswer((realInvocation) => Future.value(const Right(recipes)));

      // act
      final result = await repository.getRemoteRecipes();

      // assert
      expect(result.getOrElse(() => []).first.name, recipes.first.name);
      verify(remoteDataSource.getRecipes());
      verify(localDataSource.insertRecipes(recipes));
      verifyNoMoreInteractions(remoteDataSource);
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return failure when the call to remoteDataSource is failed',
        () async {
      const failure = Failure('something went wrong');

      // arrange
      when(remoteDataSource.getRecipes())
          .thenAnswer((realInvocation) => Future.value(const Left(failure)));

      // act
      final result = await repository.getRemoteRecipes();

      // assert
      expect(result, const Left(failure));
      verify(remoteDataSource.getRecipes());
      verifyNoMoreInteractions(remoteDataSource);
      verifyZeroInteractions(localDataSource);
    });
  });

  group('local recipes:', () {
    test(
        'should return recipes data when the call to localDataSource return with none empty or null data',
        () async {
      // arrange
      when(localDataSource.getRecipes())
          .thenAnswer((realInvocation) => Future.value(recipes));

      // act
      final result = await repository.getLocalRecipes();

      // assert
      expect(result.getOrElse(() => []).first.name, recipes.first.name);
      verify(localDataSource.getRecipes());
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should return failure when the call to localDataSource return with empty or null data',
        () async {
      // arrange
      when(localDataSource.getRecipes())
          .thenAnswer((realInvocation) => Future.value([]));

      // act
      final result = await repository.getLocalRecipes();

      // assert
      expect(result, isA<Left>());
      verify(localDataSource.getRecipes());
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
