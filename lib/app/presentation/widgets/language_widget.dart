import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../l10n/l10n.dart';
import '../locale_cubit/locale_cubit.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);

    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 72,
        child: Text(
          flag,
          style: const TextStyle(fontSize: 80),
        ),
      ),
    );
  }
}

class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<LocaleCubit>(context, listen: true);
    final locale = provider.locale;
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      value: locale,
      icon: Container(width: 12),
      items: L10n.all.map(
        (locale) {
          final flag = L10n.getFlag(locale.languageCode);

          return DropdownMenuItem(
            value: locale,
            onTap: () {
              provider.clearLocale();
              provider.setLocale(locale);
            },
            child: Center(
              child: Text(
                flag,
                style: const TextStyle(fontSize: 32),
              ),
            ),
          );
        },
      ).toList(),
      onChanged: (_) {},
    ));
  }
}
