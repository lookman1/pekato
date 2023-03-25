import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:pekato/pages/role/administator/admin/home_admin.dart';
import 'package:pekato/pages/role/administator/petugas/home_petugas.dart';
import 'package:pekato/pages/role/user/fitur/form/form_data_user.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';
import 'package:riverpod/riverpod.dart';
import '../components/snackbars.dart';
import '../model/users.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<Users?> getCurrentUsers() async {
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
        checkUsers(context);
        var getData = await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .get();
        final users = Users.fromJson(getData.data()!);

        print(users.role);
        print(getData.data()!);
        if (users.role == 'user') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeUser()),
            (route) => false,
          );
          Snackbars().successSnackbars(
              context,
              'Login Berhasil, sebagai Masyarakat',
              'Selamat Datang di Pekato! ');
        } else if (users.role == 'admin') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeAdmin()),
            (route) => false,
          );
          Snackbars().successSnackbars(context, 'Login sebagai Admin Berhasil',
              'Selamat Datang di Pekato! ');
        } else if (users.role == 'petugas') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomePetugas()),
            (route) => false,
          );
          Snackbars().successSnackbars(context,
              'Login sebagai Petugas Berhasil ', 'Selamat Datang di Pekato! ');
        }
        ;
        if (!mounted) return;
      }

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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const FormDataUser()),
          (route) => false,
        );
        Snackbars().successSnackbars(
            context, 'Sign Up berhasil!!', 'Mohon dilengkapi data diri anda! ');
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

  Future<void> getUsers({required String uid}) async {
    var checkUsers =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final users = Users.fromJson(checkUsers.data()!);
    state = users;
  }

  Future<Users?> getUser() async {
    final data = FirebaseAuth.instance.currentUser;
    if (data != null) {
      var checkUsers = await FirebaseFirestore.instance
          .collection('users')
          .doc(data.uid)
          .get();

      final users = Users.fromJson(checkUsers.data()!);
      return users;
    }
    return null;
  }

  Future<String> checkUsers(BuildContext context) async {
    final result = FirebaseAuth.instance.currentUser;
    Logger().i(result);
    if (result != null) {
      await getUsers(uid: result.uid);
      return result.uid;
    }
    return '';
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

  Future<void> tambahDataUser(BuildContext context, String nama, String nik,
      String alamat, String noTelp) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#4392A4'),
              ),
            ));

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        var getData = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        if (getData.exists) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .update({
            'nama': nama,
            'nik': nik,
            'alamat': alamat,
            'telp': noTelp,
          });
          final users = Users(
            nama: nama,
            nik: nik,
            alamat: alamat,
            telp: noTelp,
          );
          state = users;
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeUser()),
          (route) => false,
        );
        Snackbars().successSnackbars(
            context, 'Selamat datang!', 'Data berhasil disimpan');
      }
    } on FirebaseAuthException catch (e) {
      //   var error = e.message.toString();
      Snackbars().warningSnackbars(context, 'gagal', "gagal");
      Navigator.pop(context);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);
