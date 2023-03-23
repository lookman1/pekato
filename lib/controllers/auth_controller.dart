import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pekato/pages/role/admin/home_admin.dart';
import 'package:pekato/pages/role/user/form/form_data_user.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';
import 'package:riverpod/riverpod.dart';
import '../components/snackbars.dart';
import '../model/users.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<Users?> checkUsers() async {
    final result = FirebaseAuth.instance.currentUser;
    if (result != null) {
      var checkUsers = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.uid)
          .get();

      final users = Users.fromJson(checkUsers.data()!);
      return users;
    }
    return null;
  }

  Future<void> getUsers({required String uid}) async {
    var checkUsers =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final users = Users.fromJson(checkUsers.data()!);
    state = users;
  }

  Future<void> login(
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
            .collection('users')
            .doc(credential.user!.uid)
            .get();
        if (!checkUsers.exists) {
          // final users = Users.fromJson(checkUsers.data()!);
          // print(users.role);
          // print(checkUsers.data()!);
          // if (users.role == 'user') {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => const HomeUser()));
          // } else if (users.role == 'admin') {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => const HomeAdmin()));
          // } else if (users.role == 'petugas') {
          //   Navigator.pushReplacement(context,
          //       MaterialPageRoute(builder: (context) => const HomePetugas()));
          // };
        }
      }
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeUser()));

      //   Snackbars().successSnackbars(
      //       context, 'Berhasil Masuk', 'Selamat Datang di MySpp');
      //   Navigator.of(context).popUntil((route) => route.isFirst);
      //   route(context);
    } on FirebaseAuthException catch (e) {
      //   var error = e.message.toString();
      Snackbars().warningSnackbars(context, 'Email atau password salah',
          "Periksa kembali email dan password anda!");
      Navigator.pop(context);
    }
  }

  Future<void> register(BuildContext context, String email, String password,
      String confirmPassword) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));
    try {
      if (password == confirmPassword) {
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
              'role': 'user',
            });
            final users = Users(
              uid: credential.user!.uid,
              nama: '',
              nik: '',
              email: email,
              alamat: '',
              telp: '',
              role: 'user',
            );
            state = users;
          }
        }
        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const FormDataUser()));
        //   Snackbars().successSnackbars(
        //       context, 'Berhasil Masuk', 'Selamat Datang di MySpp');
        //   Navigator.of(context).popUntil((route) => route.isFirst);
        //   route(context);
      } else {
        Snackbars().warningSnackbars(context, 'Password anda tidak sesuai',
            "Pastikan kedua password anda sama");
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Snackbars().failedSnackbars(
          context, 'Email sudah terpakai', "Coba gunakan akun yang lain");
      //   var error = e.message.toString();
      //   Snackbars().failedSnackbars(
      //       context, 'Pastikan semua terisi dengan benar!', error);
      Navigator.pop(context);
    }
  }

  Future<Users?> getUser() async {
    final result = FirebaseAuth.instance.currentUser;
    if (result != null) {
      var checkUsers = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.uid)
          .get();

      final users = Users.fromJson(checkUsers.data()!);
      return users;
    }
    return null;
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Welcome();
        },
      ),
      (_) => false,
    );

    state = Users();
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);
