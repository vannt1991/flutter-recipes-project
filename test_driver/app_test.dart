import 'dart:io';
import 'package:path/path.dart';

// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

const path = r'C:\Users\omerg\AppData\Local\Android\Sdk';

Future<void> grantPermissions() async {
  try {
    final adbPath = join(
      path,
      'platform-tools',
      Platform.isWindows ? 'adb.exe' : 'adb',
    );
    await Process.run(adbPath, [
      'shell',
      'pm',
      'grant',
      'com.example.web_provise_recipes_flutter',
      'android.permission.INTERNET'
    ]);
  } catch (e) {
    print(e);
  }
}

void main() {
  group('Recipes App Test -', () {
    FlutterDriver? driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      // grant device permission
      await grantPermissions();
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver?.close();
      }
    });

    test('verifies the recipes view list contains a specific recipe',
        () async {
      // Create three SerializableFinders and use these to locate specific
      // widgets displayed by the app. The names provided to the byValueKey
      // method correspond to the Keys provided to the widgets in home_view.

      // Recipes listview
      final listFinder = find.byValueKey('recipes_list');
      // Specifie items in the listview
      final firstItemFinder = find.byValueKey('recipe10');
      final secondItemFinder = find.byValueKey('recipe1');

      // 'Refresh' FAB
      final refresh = find.byValueKey('FAB');

      // Scroll through the list
      await driver?.runUnsynchronized(() async {
        await driver?.scrollUntilVisible(
          listFinder,
          // Until finding this item
          firstItemFinder,
          // To scroll down the list, provide a negative value to dyScroll.
          // Ensure that this value is a small enough increment to
          // scroll the item into view without potentially scrolling past it.
          //
          // To scroll through horizontal lists, provide a dxScroll
          // property instead.
          dyScroll: -300.0,
        );

        // tap the 'refresh' FAB
        await driver?.tap(refresh);

        // Scroll through the list
        await driver?.scrollUntilVisible(
          listFinder,
          // Until finding this item
          secondItemFinder,
          // To scroll down the list, provide a negative value to dyScroll.
          // Ensure that this value is a small enough increment to
          // scroll the item into view without potentially scrolling past it.
          dyScroll: 10.0,
        );
        // should launch recipe from the device browser
        await driver?.tap(secondItemFinder);
      });
    });
  });
}
