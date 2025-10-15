import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../enum/constants.dart';
import '../models/portfolio_model.dart';
import '../models/user_model.dart';
import 'local_storage.dart';

part 'generated/save_user.g.dart';

class SaveUser {
  static final SaveUser _instance = SaveUser._internal();
  SaveUser._internal();
  static SaveUser get instance => _instance;
  final LocalStorage _localStorage = LocalStorage.instance;

  Future<void> saveUserData(String user) async {
    await _localStorage.saveData(key: Constants.userData.name, value: user);
  }

  Future<void> savePortfolioData(String user) async {
    await _localStorage.saveData(
      key: Constants.userPortfolioData.name,
      value: user,
    );
  }

  PortfolioModel? getPortfolioData() {
    final String? user = _localStorage.getData(
      key: Constants.userPortfolioData.name,
    );
    if (user == null) {
      return null;
    }
    return PortfolioModel.fromJson(jsonDecode(user));
  }

  UserModel? getUserData() {
    final String? user = _localStorage.getData(key: Constants.userData.name);
    if (user == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(user));
  }

  Future<void> deleteUserData() async {
    await _localStorage.deleteData(key: Constants.userData.name);
    await _localStorage.deleteData(key: Constants.userPortfolioData.name);
    await _localStorage.deleteData(key: Constants.loginKey.name);
  }
}

@riverpod
SaveUser saveUser(Ref ref) => SaveUser.instance;
