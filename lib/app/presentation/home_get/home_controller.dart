import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../../../di/injector.dart';

import '../../domain/usecases/get_local_recipe.dart';
import '../../domain/usecases/get_remote_recipe.dart';

import '../../core/network/network_info.dart';
import 'package:exam_recipes_api/app/core/usecases/usecase.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../core/errors/failure.dart';

enum ViewState { initial, busy, error, data }

class HomeController extends GetxController {
  // network info
  final network = Injector.resolve<NetworkInfoI>();
  final getRemoteRecipes = Injector.resolve<GetRemoteRecipes>();
  final getLocalRecipes = Injector.resolve<GetLocalRecipes>();
  // view state reactive value
  final viewState = ViewState.initial.obs;
  // device connectivity state reactive value
  final connectivityResult = ConnectivityResult.none.obs;
  // view state history
  final historyViewState = <ViewState>[];

  // recipes data
  List<RecipeEntity> _recipes = [];
  // recipes getter
  List<RecipeEntity> get recipes => List.from(_recipes);
  // track local/remote recipes state in view
  bool localRecipesView = false;

  @override
  Future onInit() async {
    super.onInit();
    // check for connectivity
    connectivityResult.value = await network.connectivityResult;

    if (connectivityResult.value == ConnectivityResult.none) {
      localFetch();
    } else {
      remoteFetch();
    }

    // listen to connectivity changed event and update connectvityResult value
    network.onConnectivityChanged.listen((event) {
      connectivityResult.value = event;
      // automatically evoke remote fetch if device is offline
      // and recipes data is empty, null or in local view
      if (event != ConnectivityResult.none &&
          (_recipes.isEmpty || localRecipesView)) {
        remoteFetch();
      }
    });
  }

  @override
  void onClose() {
    // close subscriptions for rx values
    viewState.close();
    connectivityResult.close();
  }

  // feth data from recipes service
  Future<void> remoteFetch() async {
    localRecipesView = false;
    if (viewState.value == ViewState.busy) return;
    if (connectivityResult.value == ConnectivityResult.none) {
      Get.snackbar("Can't refresh when offline",
          "Please connect your device to wifi or mobile network",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _setState(ViewState.busy);
    final result = await getRemoteRecipes.call(NoParams());
    _handleFetchResult(result);
  }

  // feth data from local database
  Future<void> localFetch() async {
    localRecipesView = true;
    if (viewState.value == ViewState.busy) return;
    _setState(ViewState.busy);
    final result = await getLocalRecipes.call(NoParams());
    _handleFetchResult(result, true);
  }

  // handle api fetch result
  void _handleFetchResult(Either<Failure, List<RecipeEntity>> result,
      [bool local = false]) {
    result.fold((feilure) {
      _recipes.clear();
      _setState(ViewState.error);
      Get.snackbar('Refresh failed!', "Can't load recipes",
          snackPosition: SnackPosition.BOTTOM);
    }, (data) {
    _recipes = data;
      _setState(ViewState.data);
      final notifyLocal = local ? '(offline mode)' : '';
      Get.snackbar('Refresh successfuly!',
          ' ${_recipes.length} new recipes ready for reading $notifyLocal',
          snackPosition: SnackPosition.BOTTOM);
    });
  }

  // set viewstate
  void _setState(ViewState state) {
    viewState.value = state;
    historyViewState.add(state);
  }
}
