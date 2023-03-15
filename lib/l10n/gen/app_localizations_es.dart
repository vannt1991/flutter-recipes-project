import 'app_localizations.dart';

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Español';

  @override
  String get helloWorld => 'Hola Mundo!';

  @override
  String hello(String username) {
    return 'Hola $username';
  }

  @override
  String get titleHome => 'Home as';

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
