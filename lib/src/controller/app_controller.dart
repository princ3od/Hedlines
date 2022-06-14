import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hedlines/src/constants/app_state.dart';

class AppController extends GetxController {
  var appState = AppState.loading.obs;
}
