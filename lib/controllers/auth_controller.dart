import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pekato/pages/role/admin/home_admin.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:riverpod/riverpod.dart';
import '../components/snackbars.dart';
import '../model/users.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<void> emailPassSignUp(
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
            .collection('user')
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
          context, 'Berhasil Masuk', 'Selamat Datang di Pekato');
      Navigator.of(context).popUntil((route) => route.isFirst);
      route(context);
    } on FirebaseAuthException catch (e) {
      var error = e.message.toString();
      Snackbars().failedSnackbars(context, 'Gagal Masuk', error);
      Navigator.pop(context);
    }
  }

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

  // Future<void> register(BuildContext context, String email, String password,
  //     String nama, String telp, String alamat, String level) async {
  //   FirebaseApp app = await Firebase.initializeApp(
  //       name: 'Secondary', options: Firebase.app().options);
  //   try {
  //     var userCredential = await FirebaseAuth.instanceFor(app: app)
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     await FirebaseFirestore.instance
  //         .collection('pengguna')
  //         .doc(userCredential.user!.uid)
  //         .set({
  //       'uid': userCredential.user!.uid,
  //       'email': email,
  //       'nama': nama,
  //       'telp': telp,
  //       'alamat': alamat,
  //       'level': level,
  //     });
  //     final auth = FirebaseAuth.instance;
  //     final dbLog = FirebaseFirestore.instance.collection('log_history');
  //     final doc = dbLog.doc();
  //     await doc.set({
  //       'log_id': doc.id,
  //       'aktivitas': 'Membuat akun',
  //       'email': auth.currentUser!.email,
  //       'tgl': DateTime.now(),
  //     });
  //     // ignore: use_build_context_synchronously
  //     Navigator.pop(context);
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const FormDataUser()));
  //     // ignore: use_build_context_synchronously
  //     Snackbars()
  //         .successSnackbars(context, 'Berhasil', 'Berhasil Menambah Akun');
  //   } on FirebaseAuthException catch (e) {
  //     // Do something with exception. This try/catch is here to make sure
  //     // that even if the user creation fails, app.delete() runs, if is not,
  //     // next time Firebase.initializeApp() will fail as the previous one was
  //     // not deleted.
  //     log(e.message.toString());
  //   }

  //   await app.delete();

  //   return Future.sync(() => FirebaseAuth.instanceFor(app: app));
  // }

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

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);
