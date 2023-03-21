import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pekato/pages/auth/auth_repo.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  void registrasiUser(String email, String password) {
    AuthRepo.instance.createUser(email, password);
  }

  void loginUser(String email, String password) {
    AuthRepo.instance.loginUser(email, password);
  }
}
