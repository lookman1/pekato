import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pekato/pages/role/admin/home_admin.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:riverpod/riverpod.dart';

import '../components/snackbars.dart';
import '../model/users.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<void> emailPassSignIn(
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
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        var checkUsers = await FirebaseFirestore.instance
            .collection('pengguna')
            .doc(credential.user!.uid)
            .get();
        if (!checkUsers.exists) {
          return;
        } else {
          final users = Users.fromJson(checkUsers.data()!);
          state = users;
        }
      }
      if (!mounted) return;
      Snackbars().successSnackbars(
          context, 'Berhasil Masuk', 'Selamat Datang di MySpp');
      Navigator.of(context).popUntil((route) => route.isFirst);
      route(context);
    } on FirebaseAuthException catch (e) {
      var error = e.message.toString();
      Snackbars().failedSnackbars(context, 'Gagal Masuk', error);
      Navigator.pop(context);
    }
  }

  void route(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    // ignore: unused_local_variable
    var kk = FirebaseFirestore.instance
        .collection('pengguna')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('level') == "Admin") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeAdmin(),
            ),
          );
        } else if (documentSnapshot.get('level') == "Petugas") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeAdmin(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeUser(),
            ),
          );
        }
      } else {
        return;
      }
    });
  }
}
