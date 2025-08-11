import 'package:albasrawie_dhambaal/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../core/services/storage_service.dart';
import '../../../data/models/user_model.dart';

class SettingsController extends GetxController {
  final StorageService _storageService = StorageService();

  late final UserModel? user;

  @override
  void onInit() {
    super.onInit();
    user = _storageService.getUser();
  }

  void logOut() {
    _storageService.clearUser();
    Get.offAndToNamed(AppRoutes.login);
  }
}
