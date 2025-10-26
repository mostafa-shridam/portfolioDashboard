import 'package:hive_flutter/adapters.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../enum/constants.dart';

part 'generated/local_storage.g.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  LocalStorage._internal();
  static LocalStorage get instance => _instance;
  late Box _box;

  Future<void> initHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(Constants.mainBox.name);
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    await _box.put(key, value);
  }

  dynamic getData({required String key}) {
    final data = _box.get(key);
    return data;
  }

  Future<void> deleteData({required String key}) async {
    await _box.delete(key);
  }

}

@riverpod
LocalStorage localStorage(Ref ref) => LocalStorage.instance;
