// Mocks generated by Mockito 5.3.2 from annotations
// in exam_recipes_api/test/presentation/home_bloc/recipes_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:connectivity/connectivity.dart' as _i6;
import 'package:dartz/dartz.dart' as _i3;
import 'package:exam_recipes_api/app/core/errors/failure.dart' as _i8;
import 'package:exam_recipes_api/app/core/network/network_info.dart' as _i4;
import 'package:exam_recipes_api/app/core/usecases/usecase.dart' as _i10;
import 'package:exam_recipes_api/app/domain/entities/recipe_entity.dart' as _i9;
import 'package:exam_recipes_api/app/domain/repositories/recipe_repository.dart'
    as _i2;
import 'package:exam_recipes_api/app/domain/usecases/get_local_recipe.dart'
    as _i11;
import 'package:exam_recipes_api/app/domain/usecases/get_remote_recipe.dart'
    as _i7;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRecipesRepository_0 extends _i1.SmartFake
    implements _i2.RecipesRepository {
  _FakeRecipesRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NetworkInfoI].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfoI extends _i1.Mock implements _i4.NetworkInfoI {
  @override
  _i5.Future<_i6.ConnectivityResult> get connectivityResult =>
      (super.noSuchMethod(
        Invocation.getter(#connectivityResult),
        returnValue: _i5.Future<_i6.ConnectivityResult>.value(
            _i6.ConnectivityResult.wifi),
        returnValueForMissingStub: _i5.Future<_i6.ConnectivityResult>.value(
            _i6.ConnectivityResult.wifi),
      ) as _i5.Future<_i6.ConnectivityResult>);
  @override
  _i5.Stream<_i6.ConnectivityResult> get onConnectivityChanged =>
      (super.noSuchMethod(
        Invocation.getter(#onConnectivityChanged),
        returnValue: _i5.Stream<_i6.ConnectivityResult>.empty(),
        returnValueForMissingStub: _i5.Stream<_i6.ConnectivityResult>.empty(),
      ) as _i5.Stream<_i6.ConnectivityResult>);
  @override
  _i5.Future<bool> isConnected() => (super.noSuchMethod(
        Invocation.method(
          #isConnected,
          [],
        ),
        returnValue: _i5.Future<bool>.value(false),
        returnValueForMissingStub: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
}

/// A class which mocks [GetRemoteRecipes].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetRemoteRecipes extends _i1.Mock implements _i7.GetRemoteRecipes {
  @override
  _i2.RecipesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeRecipesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeRecipesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.RecipesRepository);
  @override
  _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>> call(
          _i10.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i9.RecipeEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i9.RecipeEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>>);
}

/// A class which mocks [GetLocalRecipes].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetLocalRecipes extends _i1.Mock implements _i11.GetLocalRecipes {
  @override
  _i2.RecipesRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeRecipesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
        returnValueForMissingStub: _FakeRecipesRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.RecipesRepository);
  @override
  _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>> call(
          _i10.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i9.RecipeEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>>.value(
                _FakeEither_1<_i8.Failure, List<_i9.RecipeEntity>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i8.Failure, List<_i9.RecipeEntity>>>);
}