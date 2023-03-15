import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'event.freezed.dart';

@freezed
abstract class RecipesEvent with _$RecipesEvent {
  const factory RecipesEvent.getData() = GetData;
}
