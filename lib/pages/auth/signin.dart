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

import '../../components/session.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
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
                    'assets/svg/signin.svg',
                    height: sizeSvg.height * 0.36,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign In',
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
                            hintText: "Masukan email anda",
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
                        obscureText: passenable,
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong';
                          } else if (value.length <= 8) {
                            return 'password minimal 8 karakter';
                          }
                          return null;
                        }),
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: green3, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            errorBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.red, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: green3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "Masukan password anda",
                            hintStyle: const TextStyle(
                              fontSize: 18,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: green3,
                              size: 24.0,
                            ),
                            suffixIcon: IconButton(
                              color: green4,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  if (passenable) {
                                    passenable = false;
                                  } else {
                                    passenable = true;
                                  }
                                });
                              },
                              icon: Icon(passenable == true
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded),
                            ),
                            labelText: "password",
                            labelStyle: TextStyle(color: green3),
                            isDense: true,
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ResetPass()));
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: greenLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                        if (_formKey.currentState!.validate()) {
                          try {
                            await ref
                                .read(authControllerProvider.notifier)
                                .login(context, email.text, password.text);
                            password.clear();
                            setState(() {});
                            await createSession(
                                FirebaseAuth.instance.currentUser!.uid);
                            log(getSession().toString());
                            if (!mounted) return;
                          } catch (e) {
                            print(e);
                          }
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Profile()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: greenLight,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: greenLight),
                            )),
                      ],
                    )
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
