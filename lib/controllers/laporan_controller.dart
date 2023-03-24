import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pekato/pages/role/administator/admin/home_admin.dart';
import 'package:pekato/pages/role/user/pages/form/form_data_user.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';
import 'package:riverpod/riverpod.dart';
import '../components/snackbars.dart';
import '../model/laporan.dart';
import '../model/users.dart';

class LaporanController extends StateNotifier<Laporan> {
  LaporanController() : super(Laporan());

  Future<void> kirimLaporan(BuildContext context, String nik, String tempat,
      String jenis, String tanggal, String isi, String foto) async {
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
        await FirebaseFirestore.instance.collection('laporan').doc().set({
          'nik': nik,
          'uid': currentUser.uid,
          'tempat': tempat,
          'jenis': jenis,
          'tanggal': tanggal,
          'isi': isi,
          'foto': '',
        });
        final laporan = Laporan(
          nik: nik,
          uid: currentUser.uid,
          tempat: tempat,
          jenis: jenis,
          tanggal: tanggal,
          isi: isi,
          foto: '',
        );
        state = laporan;
      }
      Snackbars().successSnackbars(context, 'Succes!', "Laporan Terkirim");
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeUser()));
    } on FirebaseFirestore catch (e) {}
  }
}

final laporanControllerProvider =
    StateNotifierProvider<LaporanController, Laporan>(
  (ref) => LaporanController(),
);
