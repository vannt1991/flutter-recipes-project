// ignore_for_file: constant_identifier_names

import 'package:exam_recipes_api/app/presentation/home_riverpod/view/home_view_async.dart';

import '../presentation/home_riverpod/view/home_view.dart';
import '../presentation/home_riverpod_code_gen/home_view_async.dart';
import '../presentation/index.dart';

import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOADING;

  static final blocRoutes = [
    GetPage(
      name: Routes.HOME,
      binding: HomeBinding(),
      page: () => const HomeViewBloc(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
  ];

  static final cubitRoutes = [
    GetPage(
      name: Routes.HOME,
      binding: HomeBinding(),
      page: () => const HomeViewCubit(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
  ];

  static final getRoutes = [
    GetPage(
      name: Routes.HOME,
      binding: HomeBinding(),
      page: () => const HomeViewGetX(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
  ];

  static final riverPodRoutes = [
    GetPage(
      name: Routes.HOME,
      binding: HomeBinding(),
      page: () => const HomeViewRiverPodCodeGen(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}
