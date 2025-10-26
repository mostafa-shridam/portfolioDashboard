import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../enum/constants.dart';
import '../models/about.dart';
import '../models/education.dart';
import '../models/experience.dart';
import '../models/portfolio_model.dart';
import '../models/user_model.dart';
import 'local_storage.dart';

part 'generated/save_user.g.dart';

class SaveUser {
  static final SaveUser _instance = SaveUser._internal();
  SaveUser._internal();
  static SaveUser get instance => _instance;
  final LocalStorage _localStorage = LocalStorage.instance;

  // user data in local storage
  Future<void> saveUserData(String user) async {
    await _localStorage.saveData(key: Constants.userData.name, value: user);
  }

  UserModel? getUserData() {
    final String? user = _localStorage.getData(key: Constants.userData.name);
    if (user == null) {
      return null;
    }
    return UserModel.fromJson(jsonDecode(user));
  }

  // update user data in local storage
  Future<UserModel?> updateUserData(UserModel newUser) async {
    await _localStorage.saveData(
      key: Constants.userData.name,
      value: jsonEncode(newUser),
    );
    return newUser;
  }

  // delete user data in local storage
  Future<void> deleteUserData() async {
    await _localStorage.deleteData(key: Constants.userData.name);
    await _localStorage.deleteData(key: Constants.userPortfolioData.name);
    await _localStorage.deleteData(key: Constants.loginKey.name);
  }

  // portfolio data in local storage
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

  // about data in local storage
  Future<void> saveAboutData(String about) async {
    await _localStorage.saveData(key: Constants.aboutData.name, value: about);
  }

  AboutModel? getAboutData() {
    final String? about = _localStorage.getData(key: Constants.aboutData.name);
    if (about == null) {
      return null;
    }
    return AboutModel.fromJson(jsonDecode(about));
  }

  Future<void> saveWorkExperience(String workExperience) async {
    await _localStorage.saveData(
      key: Constants.workExperience.name,
      value: workExperience,
    );
  }

  List<Experience>? getWorkExperience() {
    final String? workExperience = _localStorage.getData(
      key: Constants.workExperience.name,
    );
    if (workExperience == null) {
      return null;
    }
    return (jsonDecode(workExperience) as List)
        .map((e) => Experience.fromJson(e))
        .toList();
  }

  Future<void> saveEducation(String education) async {
    await _localStorage.saveData(
      key: Constants.education.name,
      value: education,
    );
  }

  List<Education>? getEducation() {
    final String? education = _localStorage.getData(
      key: Constants.education.name,
    );
    if (education == null) {
      return null;
    }
    return (jsonDecode(education) as List)
        .map((e) => Education.fromJson(e))
        .toList();
  }
}

@riverpod
SaveUser saveUser(Ref ref) => SaveUser.instance;
