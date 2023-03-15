import 'package:freezed_annotation/freezed_annotation.dart';

part 'locale_state.freezed.dart';

@freezed
class LocaleState with _$LocaleState {
  const factory LocaleState.initial() = Initial;
  const factory LocaleState.loading() = Loading;
  const factory LocaleState.success() = Success;
  const factory LocaleState.error(Exception failure) = Error;
}
