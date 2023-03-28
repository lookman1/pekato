import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import '../../../../../controllers/laporan_controller.dart';
import '../../../../../styles/color.dart';

class Tanggapan extends StatefulWidget {
  final String? idLaporan;
  final String? status;
  const Tanggapan({super.key, required this.idLaporan, required this.status});

  @override
  State<Tanggapan> createState() => _TanggapanState();
}

class _TanggapanState extends State<Tanggapan> {
  late Future<QuerySnapshot> _futureUser;
  List<Map> _userItems = [];

  @override
  void initState() {
    super.initState();
    _futureUser = getData();
    _futureUser.then((value) {
      setState(() {
        _userItems = parseData(value);
      });
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentuser!.uid)
        .get();
    return data;
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((data) => {
              'id_user': data['uid'],
              'nama_User': data['nama'],
              'noTelp_User': data['telp'],
            })
        .toList();
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgGreen,
      body: SafeArea(
          child: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: bgbutton,
                      boxShadow: [
                        BoxShadow(
                            color: green1, blurRadius: 1.0, spreadRadius: 1.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        hoverColor: green2,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                  const Center(
                    child: Text(
                      "Form Tanggapan",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                          color: green4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: size.height * 0.4,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: greenLight,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.circular(25.0)),
                child: Column(children: [ListView(children: [])]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: SizedBox(
                      width: 120.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {} catch (e) {}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenLight,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                          child: const Text("Kirim")),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                )
              ],
            ),
          ],
        ),
      ])),
    );
  }
}
