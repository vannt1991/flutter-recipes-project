import 'package:exam_recipes_api/app/theme/theme_data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as _get;

import 'app/presentation/locale_cubit/locale_cubit.dart';
import 'app/routes/app_pages.dart';
import 'di/injector.dart';
import 'l10n/gen/app_localizations.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Injector.setup();
  runApp(ProviderScope(
    child: BlocProvider<LocaleCubit>(
      create: (_) => Injector.resolve<LocaleCubit>(),
      child: Builder(
        builder: (context) {
          final fixedLocale = context.watch<LocaleCubit>().locale;
          _get.Get.updateLocale(fixedLocale);
          return _get.GetMaterialApp(
            scrollBehavior: MyCustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            defaultTransition: _get.Transition.topLevel,
            onGenerateTitle: (context) {
              return AppLocalizations.of(context)!.titleHome;
            },
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.riverPodRoutes,
            theme: lightThemeData(),
            darkTheme: darkThemeData(),
            supportedLocales: L10n.all,
            locale: fixedLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          );
        },
      ),
    ),
  ));
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
