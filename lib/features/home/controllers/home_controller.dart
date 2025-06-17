import 'package:get/get.dart';
import '../../../core/services/storage_service.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  final StorageService _storageService = StorageService();

  late final UserModel? user;

  @override
  void onInit() {
    super.onInit();
    user = _storageService.getUser();
  }
}