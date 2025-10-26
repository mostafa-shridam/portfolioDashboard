import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/enum/constants.dart';
import '../../../../core/local_service/save_user.dart';
import '../../../../core/models/about.dart';
import '../../../../core/models/experience.dart';

part 'generated/about_provider.g.dart';

@riverpod
class AboutProvider extends _$AboutProvider {
  late FirebaseFirestore _firestore;
  late FirebaseAuth _auth;
  late SaveUser _saveUser;
  @override
  AboutState build() {
    _firestore = FirebaseFirestore.instance;
    _auth = FirebaseAuth.instance;
    _saveUser = SaveUser.instance;
    return AboutState();
  }

  Future<void> addAboutData(AboutModel about) async {
    state = state.copyWith(isLoading: true);
    try {
      about.userId = _auth.currentUser?.uid;
      await _firestore
          .collection(Constants.aboutData.name)
          .doc(_auth.currentUser?.uid)
          .set(about.toJson());
      await _saveUser.saveAboutData(jsonEncode(about.toJson()));
      state = state.copyWith(about: about, isLoading: false);
      if (kDebugMode) {
        log('about data added successfully: ${about.toJson()}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (kDebugMode) {
        log('error adding about data: $e');
      }
      rethrow;
    }
  }

  // get about data from local storage
  Future<void> getAboutData() async {
    state = state.copyWith(isLoading: true);
    try {
      if (kDebugMode) {
        log('getting about data from local storage');
      }
      if (_auth.currentUser?.uid == null) {
        if (kDebugMode) {
          log('user is not authenticated');
        }
        return;
      }
      AboutModel? about;
      final aboutData = await _firestore
          .collection(Constants.aboutData.name)
          .doc(_auth.currentUser?.uid)
          .get();
      if (aboutData.exists) {
        about = AboutModel.fromJson(aboutData.data() ?? {});
        if (kDebugMode) {
          log('about data: ${about.toJson()}');
        }
        await _saveUser.saveAboutData(jsonEncode(about.toJson()));
        state = state.copyWith(about: about);
        if (kDebugMode) {
          log('about data saved to local storage');
        }
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (kDebugMode) {
        log('error getting about data: $e');
      }
      rethrow;
    }
  }

  Future<void> addWorkExperience(Experience experience) async {
    state = state.copyWith(isLoading: true);

    try {
      experience.id = _auth.currentUser?.uid;
      await _firestore
          .collection(Constants.workExperience.name)
          .doc(_auth.currentUser?.uid)
          .set(experience.toJson());
      await _saveUser.saveWorkExperience(jsonEncode(experience.toJson()));
      state = state.copyWith(
        workExperience: [...state.workExperience ?? [], experience],
      );
      await _saveUser.saveWorkExperience(jsonEncode(state.workExperience));
      if (kDebugMode) {
        log('work experience added successfully: ${experience.toJson()}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (kDebugMode) {
        log('error adding work experience: $e');
      }
      rethrow;
    }
  }

  Future<void> getWorkExperience() async {
    state = state.copyWith(isLoading: true);
    try {
      state = state.copyWith(workExperience: _saveUser.getWorkExperience());
    } catch (e) {
      state = state.copyWith(isLoading: false);
      if (kDebugMode) {
        log('error getting work experience: $e');
      }
      rethrow;
    }
  }
}

class AboutState {
  AboutModel? about;
  List<Experience>? workExperience;
  bool? isLoading;
  bool? isCurrentPosition;

  AboutState({
    this.about,
    this.isLoading,
    this.isCurrentPosition,
    this.workExperience,
  });

  AboutState copyWith({
    AboutModel? about,
    bool? isLoading,
    bool? isCurrentPosition,
    List<Experience>? workExperience,
  }) {
    return AboutState(
      about: about ?? this.about,
      isLoading: isLoading ?? this.isLoading,
      isCurrentPosition: isCurrentPosition ?? this.isCurrentPosition,
      workExperience: workExperience ?? this.workExperience,
    );
  }
}
