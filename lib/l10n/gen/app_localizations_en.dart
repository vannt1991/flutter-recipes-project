import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String hello(String username) {
    return 'Hello $username';
  }

  @override
  String get titleHome => 'Recipes';

  @override
  String get description => 'Description';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get calories => 'Calories';

  @override
  String get proteins => 'Proteins';

  @override
  String get fats => 'Fats';

  @override
  String get carbos => 'Carbos';
}
