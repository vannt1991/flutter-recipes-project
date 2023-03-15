import 'app_localizations.dart';

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get language => 'Deutsch';

  @override
  String get helloWorld => 'Hallo Welt!';

  @override
  String hello(String username) {
    return 'Hallo $username';
  }

  @override
  String get titleHome => 'Rezepte';

  @override
  String get description => 'Beschreibung';

  @override
  String get ingredients => 'Zutaten';

  @override
  String get calories => 'Calories';

  @override
  String get proteins => 'Proteins';

  @override
  String get fats => 'Fats';

  @override
  String get carbos => 'Carbos';
}
