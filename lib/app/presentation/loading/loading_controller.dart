import 'dart:async';

import 'package:get/get.dart';
import 'package:exam_recipes_api/app/data/datasources/local/recipe_local_datasource.dart';
import '../../routes/app_pages.dart';

import '../../../di/injector.dart';

class LoadingController extends GetxController {
  @override
  Future onInit() async {
    super.onInit();
    await Injector.resolve<RecipesLocalDataSource>().initDb();
    await Future.delayed(const Duration(seconds: 1));
    Get.offAndToNamed(Routes.HOME);
  }
}
