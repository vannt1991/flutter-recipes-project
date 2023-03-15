import 'app_localizations.dart';

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get language => 'मानक हिन्दी';

  @override
  String get helloWorld => 'नमस्ते दुनिया!';

  @override
  String hello(String username) {
    return 'नमस्ते $username';
  }

  @override
  String get titleHome => 'नमस्ते दुनिया!';

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
