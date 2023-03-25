import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:pekato/controllers/laporan_controller.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/styles/color.dart';

import '../../../../../model/users.dart';

class FormDataUser extends ConsumerStatefulWidget {
  const FormDataUser({super.key});

  @override
  ConsumerState<FormDataUser> createState() => _FormDataUserState();
}

class _FormDataUserState extends ConsumerState<FormDataUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController nik = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController noTelp = TextEditingController();

  Future<void> getDataUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var checkUsers = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final users = Users.fromJson(checkUsers.data()!);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    final sizeSvg = MediaQuery.of(context).size;
    final user = ref.read(authControllerProvider);
    return Scaffold(
      backgroundColor: greenLight,
      body: ListView(children: [
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
              child: Text(
                "Data \nMasyarakat",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: green4,
                ),
              ),
            ),
            Center(
                child: SvgPicture.asset(
              'assets/svg/dataPerson.svg',
              height: sizeSvg.height * 0.4,
            )),

            //form
            Container(
              decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40.0)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Masukan Data Anda",
                        style: TextStyle(
                            fontSize: 23.0,
                            fontWeight: FontWeight.w600,
                            color: green4),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nama",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: green4),
                          ),
                          TextFormField(
                            cursorColor: green4,
                            controller: nama,
                            keyboardType: TextInputType.name,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'nama tidak boleh kosong';
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: green3, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2.0, color: green3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              hintText: "Masukan Nama Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: const TextStyle(fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "NIK",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: green4),
                          ),
                          TextFormField(
                            cursorColor: green4,
                            controller: nik,
                            keyboardType: TextInputType.number,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'NIK tidak boleh kosong';
                              } else if (value.length <= 16) {
                                return 'NIK tidak lengkap';
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: green3, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2.0, color: green3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              hintText: "Masukan NIK Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: const TextStyle(fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "Alamat",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: green4),
                          ),
                          TextFormField(
                            cursorColor: green4,
                            controller: alamat,
                            keyboardType: TextInputType.name,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'Alamat tidak boleh kosong';
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: green3, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2.0, color: green3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              hintText: "Masukan Alamat Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: const TextStyle(fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "No. Telepon",
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                                color: green4),
                          ),
                          TextFormField(
                            cursorColor: green4,
                            controller: noTelp,
                            keyboardType: TextInputType.name,
                            validator: ((value) {
                              if (value!.isEmpty) {
                                return 'No Telepon tidak boleh kosong';
                              } else if (value.length <= 11) {
                                return 'No Telepon tidak lengkap';
                              }
                              return null;
                            }),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: green3, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 3.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 2.0, color: green3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              hintText: "Masukan No. Telepon Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: const TextStyle(fontSize: 15.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Center(
                              child: SizedBox(
                                height: 40.0,
                                width: 120.0,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await ref
                                              .read(authControllerProvider
                                                  .notifier)
                                              .tambahDataUser(
                                                  context,
                                                  nama.text,
                                                  nik.text,
                                                  alamat.text,
                                                  noTelp.text);
                                          nama.clear();
                                          nik.clear();
                                          alamat.clear();
                                          noTelp.clear();
                                        } catch (e) {}
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: green2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0))),
                                    child: const Text(
                                      "Simpan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ]),
    );
  }
}
