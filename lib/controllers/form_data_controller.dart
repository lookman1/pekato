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

class FormDataController extends StateNotifier<Users> {
  FormDataController() : super(Users());

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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeUser()));
      }
    } on FirebaseAuthException catch (e) {
      //   var error = e.message.toString();
      Snackbars().warningSnackbars(context, 'gagal', "gagal");
      Navigator.pop(context);
    }
  }
}

final formDataControllerProvider =
    StateNotifierProvider<FormDataController, Users>(
  (ref) => FormDataController(),
);
