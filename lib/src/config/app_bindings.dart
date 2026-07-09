import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jamil_project/src/repos/auth_repository.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/utils/local_storage.dart';

class AppBindings extends Bindings {
  AppBindings(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  void dependencies() {
    Get.put(LocalStorage(sharedPreferences), permanent: true);
    Get.put(AuthRepository(Get.find<LocalStorage>()), permanent: true);
    Get.put(AuthController(Get.find<AuthRepository>()), permanent: true);
  }
}
