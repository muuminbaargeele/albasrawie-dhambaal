import 'package:get_storage/get_storage.dart';
import '../../data/models/user_model.dart';

class StorageService {
  final _box = GetStorage();
  final _userKey = 'user';

  void saveUser(UserModel user) {
    _box.write(_userKey, user.toJson());
  }

  UserModel? getUser() {
    final json = _box.read(_userKey);
    return json != null ? UserModel.fromJson(json) : null;
  }

  void clearUser() {
    _box.remove(_userKey);
  }

  bool isLoggedIn() {
    return _box.hasData(_userKey);
  }
}