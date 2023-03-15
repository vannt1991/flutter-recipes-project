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

  @override
  String get description => 'Mô tả';

  @override
  String get ingredients => 'Thành phần';

  @override
  String get calories => 'Calories';

  @override
  String get proteins => 'Proteins';

  @override
  String get fats => 'Fats';

  @override
  String get carbos => 'Carbos';
}
