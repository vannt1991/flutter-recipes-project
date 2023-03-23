// ignore_for_file: constant_identifier_names

import '../presentation/home_riverpod/view/home_view.dart';
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
      page: () => const HomeViewRiverPod(),
    ),
    GetPage(
      name: Routes.LOADING,
      page: () => const LoadingView(),
      binding: LoadingBinding(),
    ),
  ];
}
