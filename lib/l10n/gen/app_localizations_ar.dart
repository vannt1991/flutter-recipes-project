import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get language => 'العربية';

  @override
  String get helloWorld => '!مرحبا بالعالم';

  @override
  String hello(String username) {
    return '$username مرحبا';
  }

  @override
  String get titleHome => 'العربية';

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
