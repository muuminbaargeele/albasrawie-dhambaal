import 'package:get/get.dart';
import '../../chats/controllers/chats_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
    Get.lazyPut(() => ChatsController());
  }
}