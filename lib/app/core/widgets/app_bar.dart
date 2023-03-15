import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/gen/app_localizations.dart';

PreferredSizeWidget appBar({List<Widget>? moreActions}) {
  return AppBar(
    elevation: 8.0,
    // backgroundColor: Colors.yellow,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.adb,
          color: Colors.black,
        ),
        const SizedBox(
          width: 6.0,
        ),
        Builder(builder: (context) {
          return Text(
            AppLocalizations.of(context)!.titleHome,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          );
        }),
      ],
    ).paddingAll(4.0),
    actions: [if (moreActions != null) ...moreActions],
  );
}
