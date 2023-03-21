import 'package:firebase_auth/firebase_auth.dart';
import 'package:pekato/pages/home/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthRepo extends GetxController {
  static AuthRepo get instance => Get.find();

  //Variabels
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const Welcome())
        : Get.offAll(() => const HomeUser());
  }

  Future<void> createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeUser())
          : Get.offAll(() => const Welcome());

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const HomeUser()));
    } on FirebaseAuthException catch (e) {
      printError();
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => const HomeUser())
          : Get.offAll(() => const Welcome());
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }

  Future<void> logoutUser() async => await _auth.signOut();
}
