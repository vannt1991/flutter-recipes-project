import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:exam_recipes_api/app/core/errors/failure.dart';
import 'package:exam_recipes_api/app/domain/entities/recipe_entity.dart';

part 'state.freezed.dart';

@freezed
abstract class RecipesState with _$RecipesState {
  const factory RecipesState.initial() = Initial;
  const factory RecipesState.loading() = Loading;
  const factory RecipesState.success(List<RecipeEntity> recipes) = Success;
  const factory RecipesState.error(Failure failure) = Error;
}
