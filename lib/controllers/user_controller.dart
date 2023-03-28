import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:pekato/model/laporan.dart';
import 'package:pekato/pages/role/administator/admin/home_admin.dart';
import 'package:pekato/pages/role/administator/petugas/home_petugas.dart';
import 'package:pekato/pages/role/user/fitur/form/form_data_user.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';
import 'package:riverpod/riverpod.dart';
import '../components/snackbars.dart';
import '../model/users.dart';

class UserController extends StateNotifier<Users> {
  UserController() : super(Users());

  Future<void> tambahPetugas(
      BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        var checkUsers = await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .get();
        if (!checkUsers.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(credential.user!.uid)
              .set({
            'uid': credential.user!.uid,
            'nama': '',
            'nik': '',
            'email': email,
            'alamat': '',
            'telp': '',
            'role': 'petugas',
          });
          final users = Users(
            uid: credential.user!.uid,
            nama: '',
            nik: '',
            email: email,
            alamat: '',
            telp: '',
            role: 'petugas',
          );
          state = users;
        }
      }
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeAdmin()),
        (route) => false,
      );
      Snackbars().successSnackbars(context, 'Akun berhasil dibuat',
          'akun petugas baru sudah bisa digunakan');
    } on FirebaseAuthException catch (e) {
      Snackbars().failedSnackbars(
          context, 'Email sudah terpakai', "Coba gunakan akun yang lain");
      //   var error = e.message.toString();
      //   Snackbars().failedSnackbars(
      //       context, 'Pastikan semua terisi dengan benar!', error);
      Navigator.pop(context);
    }
  }
}

final userControllerProvider = StateNotifierProvider<UserController, Users>(
  (ref) => UserController(),
);
