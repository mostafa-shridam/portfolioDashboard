import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:userportfolio/core/enum/constants.dart';

import '../../../../core/local_service/local_storage.dart';
import '../../../../core/local_service/save_user.dart';
import '../../../../core/mixins/scaffold_messeneger.dart';
import '../../../../core/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../home/data/providers/home_provider.dart';
import '../../../home/presentation/home_page.dart';
import '../../presentation/auth_page.dart';

part 'generated/auth.g.dart';

@riverpod
class Auth extends _$Auth with ScaffoldMessengerMixin {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;
  late SaveUser _saveUser;
  GoogleSignIn googleSignIn = GoogleSignIn.instance;
  @override
  AuthState build() {
    _auth = FirebaseAuth.instance;
    _saveUser = SaveUser.instance;
    _firestore = FirebaseFirestore.instance;
    _googleInit();
    return AuthState();
  }

  Future<void> _googleInit() async {
    if (kIsWeb) {
      await googleSignIn.initialize();
      return;
    }
    await googleSignIn.initialize(
      serverClientId:
          '679089501335-rs37e0g046sioenham5oedpj3m93hvqj.apps.googleusercontent.com',
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    // Check if context is still mounted before starting
    if (!context.mounted) return;

    state = state.copyWith(isLoading: true);
    try {
      UserCredential userCredential;
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      log('start authenticate');
      if (kIsWeb) {
        userCredential = await _auth.signInWithPopup(googleProvider);
        if (!ref.mounted || !context.mounted) {
          state = state.copyWith(isLoading: false);
        }
        state = state.copyWith(isLoading: false);
      } else {
        final GoogleSignInAccount googleUser = await googleSignIn
            .authenticate();

        final GoogleSignInAuthentication googleSignInAuthentication =
            googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
        );

        userCredential = await _auth.signInWithCredential(credential);
      }

      // Check if provider is still mounted after async operation
      if (!ref.mounted) return;

      log('userCredential.user: ${userCredential.user}');

      if (userCredential.user == null) {
        log('user is null');
        state = state.copyWith(isLoading: false);

        return;
      }
      final User? user = userCredential.user;
      final getUserData = await _firestore
          .collection(Constants.portfolioUser.name)
          .doc(user?.uid)
          .get();
      final UserModel userModel = UserModel(
        id: user?.uid ?? '',
        email: user?.email ?? '',
        profileImage: user?.photoURL ?? '',
        name: user?.displayName ?? '',
        bio: 'Hello, I\'m',
        phone: user?.phoneNumber ?? '',
        provider: 'google',
        authType: kIsWeb ? 'web' : 'mobile',
      );

      if (getUserData.exists) {
        log('user data exists');
        final userModel = UserModel.fromJson(getUserData.data() ?? {});
        await _saveUser.saveUserData(jsonEncode(userModel.toJson()));

        // Check if provider is still mounted after async operation
        if (!ref.mounted) return;

        state = state.copyWith(isLoading: false, user: userModel);
        LocalStorage.instance.saveData(
          key: Constants.loginKey.name,
          value: true,
        );
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      } else {
        log('start add user to firestore');

        if (userModel.id != null) {
          await _firestore
              .collection(Constants.portfolioUser.name)
              .doc(userModel.id)
              .set(userModel.toJson());

          // Check if provider is still mounted after async operation
          if (!ref.mounted) return;
        }
        await _saveUser.saveUserData(jsonEncode(userModel.toJson()));

        // Check if provider is still mounted after async operation
        if (!ref.mounted) return;

        state = state.copyWith(isLoading: false, user: userModel);
        LocalStorage.instance.saveData(
          key: Constants.loginKey.name,
          value: true,
        );
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      }
    } on GoogleSignInException catch (e) {
      log('on FirebaseAuthException catch ($e)');
      if (context.mounted) {
        showSnackBar(
          context: context,
          message: e.description ?? 'Something went wrong',
        );
      }
      // Check if provider is still mounted before updating state
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false);
    } catch (e) {
      log('catch ($e)');
      if (context.mounted) {
        showSnackBar(context: context, message: e.toString());
      }
      // Check if provider is still mounted before updating state
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false);
    } finally {
      if (ref.mounted) {
        state = state.copyWith(isLoading: false);
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
      await _saveUser.deleteUserData();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AuthPage.routeName);
      }
      // Check if provider is still mounted before updating state
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, user: null);
    } catch (e) {
      log('Error signing out: $e');
      // Check if provider is still mounted before updating state
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _deleteAccountData() async {
    try {
      await _firestore
          .collection(Constants.portfolioUser.name)
          .doc(_auth.currentUser?.uid)
          .delete();
      await _saveUser.deleteUserData();
    } catch (e) {
      log('Error deleting account data: $e');
    }
  }

  Future<void> deleteAccont(BuildContext context) async {
    try {
      await _deleteAccountData();
      await _auth.currentUser?.reload();
      await _auth.currentUser?.delete();
      await googleSignIn.signOut();
      await googleSignIn.disconnect();
      await _auth.signOut();

      if (context.mounted) {
        Navigator.pushReplacementNamed(context, AuthPage.routeName);
      }
      // Check if provider is still mounted before updating state
      if (!ref.mounted) return;

      state = state.copyWith(isLoading: false, user: null);
    } catch (e) {
      log('Error signing out: $e');
      // Check if provider is still mounted before updating state
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false);
    }
  }

  void updateSelectedColor() async {
    state = state.copyWith(isLoading: true);
    try {
      final color =
          ref.watch(homeProviderProvider).colorCallback?.toARGB32() ?? 0;
      final userModel = ref.watch(saveUserProvider).getUserData();
      if (userModel == null) {
        state = state.copyWith(isLoading: false);
        return;
      }
      userModel.selectedColor = color;
      if (_auth.currentUser?.uid == null) {
        state = state.copyWith(isLoading: false);
        return;
      }
      await _firestore
          .collection(Constants.portfolioUser.name)
          .doc(_auth.currentUser?.uid)
          .update(userModel.toJson());
      await _saveUser.updateUserData(userModel);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateUserData(UserModel userModel) async {
    state = state.copyWith(isLoading: true);
    try {
      final color =
          ref.watch(homeProviderProvider).colorCallback?.toARGB32() ?? 0;
      userModel.selectedColor = color;
      if (_auth.currentUser?.uid == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      if (!ref.mounted) return;
      await _saveUser.updateUserData(userModel);
      if (!ref.mounted) return;
      await _firestore
          .collection(Constants.portfolioUser.name)
          .doc(_auth.currentUser?.uid)
          .update(userModel.toJson());
      state = state.copyWith(isLoading: false, user: userModel);
    } catch (e) {
      log('Error updating user data: $e');
      state = state.copyWith(isLoading: false, user: null);
    }
  }
}

class AuthState {
  bool? isLoading;
  UserModel? user;

  AuthState({this.isLoading, this.user});

  AuthState copyWith({bool? isLoading, UserModel? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
