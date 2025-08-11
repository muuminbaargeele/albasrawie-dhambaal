import 'package:get/get.dart';
import '../core/services/storage_service.dart';
import '../features/settings/controllers/settings_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService(), permanent: true);
    Get.put(SettingsController(), permanent: true);
  }
}