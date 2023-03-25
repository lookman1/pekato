import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:pekato/pages/auth/reset_pass.dart';
import 'package:pekato/pages/auth/signup.dart';
import 'package:pekato/pages/role/administator/admin/home_admin.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/role/user/fitur/profile.dart';
import 'package:pekato/styles/color.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class TambahPetugas extends ConsumerStatefulWidget {
  const TambahPetugas({super.key});

  @override
  ConsumerState<TambahPetugas> createState() => _TambahPetugasState();
}

class _TambahPetugasState extends ConsumerState<TambahPetugas> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passenable = true; //track password value

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeSvg = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
                  child: SvgPicture.asset(
                    'assets/svg/petugas.svg',
                    height: sizeSvg.height * 0.4,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tambah Petugas',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                        color: green3),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        cursorColor: green4,
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        }),
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: green3, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: green3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "Masukan email petugas",
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: green3,
                              size: 24.0,
                            ),
                            labelText: "email",
                            labelStyle: TextStyle(color: green3),
                            isDense: true,
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        cursorColor: green4,
                        controller: password,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        }),
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: green3, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: green3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "Masukan password petugas",
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: green3,
                              size: 24.0,
                            ),
                            labelText: "password",
                            labelStyle: TextStyle(color: green3),
                            isDense: true,
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    )
                  ],
                ),
              ),
              //buttom component
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {}
                        try {
                          await ref
                              .read(authControllerProvider.notifier)
                              .tambahPetugas(
                                  context, email.text, password.text);
                          password.clear();
                        } catch (e) {
                          print(e);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: green3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Tambah',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
