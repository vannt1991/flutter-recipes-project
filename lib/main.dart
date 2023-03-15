import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:exam_recipes_api/app/theme/theme_data.dart';
import 'package:provider/provider.dart';
import 'app/presentation/widgets/language_widget.dart';
import 'app/routes/app_pages.dart';
import 'di/injector.dart';
import 'l10n/gen/app_localizations.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Injector.setup();
  runApp(ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      builder: (context, child) {
        final fixedLocale =
            context.watch<LocaleProvider>().locale ?? const Locale('en');
        Get.updateLocale(fixedLocale);
        return GetMaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.topLevel,
          onGenerateTitle: (context) {
            return AppLocalizations.of(context)!.titleHome;
          },
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.getRoutes,
          theme: lightThemeData(),
          darkTheme: darkThemeData(),
          supportedLocales: L10n.all,
          locale: fixedLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        );
      }));
}

// support desktop app (windows or macos)
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
