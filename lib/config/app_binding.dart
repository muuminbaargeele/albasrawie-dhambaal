import 'package:get/get.dart';
import '../core/services/storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService(), permanent: true);
  }
}