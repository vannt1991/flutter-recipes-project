import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/l10n.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  Locale? _locale;

  LocaleCubit() : super(const LocaleState.initial());

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    this._locale = locale;
    emit(const LocaleState.success());
  }

  Locale get locale => _locale ?? const Locale('en');

  void clearLocale() {
    _locale = null;
    emit(const LocaleState.initial());
  }
}
