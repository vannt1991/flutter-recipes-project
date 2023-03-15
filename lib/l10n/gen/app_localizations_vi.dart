import 'app_localizations.dart';

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get language => 'Việt Nam';

  @override
  String get helloWorld => 'Xin chào thế giới';

  @override
  String hello(String username) {
    return 'Xin chào $username';
  }

  @override
  String get titleHome => 'Công thức nấu ăn';
}
