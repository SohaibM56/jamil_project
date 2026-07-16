import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/repos/auth_repository.dart';
import 'package:jamil_project/src/repos/card_repository.dart';
import 'package:jamil_project/src/repos/storage_repository.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(
      AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
      permanent: true,
    );
    Get.put(AuthController(Get.find<AuthRepository>()), permanent: true);
    Get.put(CardRepository(FirebaseFirestore.instance), permanent: true);
    Get.put(StorageRepository(FirebaseStorage.instance), permanent: true);
  }
}
