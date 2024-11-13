import 'dart:convert';

import '../models/user_model.dart';
import '../services/storages/service.dart';

class StorageProvider {
  final StorageService _storageService = StorageService();

  Future<void> writeUserModel(UserModel user) async {
    _storageService.write("", jsonEncode(user));
  }

  Future<UserModel> readUserModel() async {
    var data = _storageService.read("") ?? "";
    if (data == "") {
      return UserModel();
    } else {
      UserModel user = UserModel.fromJson(jsonDecode(data));
      return user;
    }
  }
}
