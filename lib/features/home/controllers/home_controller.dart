import 'package:get/get.dart';
import '../../../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();

  final isFetching = false.obs;

  // Future fetch logic here
}