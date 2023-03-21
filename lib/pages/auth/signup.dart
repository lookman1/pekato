import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:pekato/pages/auth/signin.dart';
import 'package:pekato/pages/role/user/form/form_data_user.dart';
import 'package:pekato/styles/color.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SvgPicture.asset(
                    'assets/svg/auth.svg',
                    height: sizeSvg.height * 0.4,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
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
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: green3, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "email",
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
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: green3, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: green3,
                              size: 20.0,
                            ),
                            labelText: "password",
                            labelStyle: TextStyle(color: green3),
                            isDense: true,
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: green3, width: 3.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: "confirm password",
                            hintStyle: TextStyle(
                              fontSize: 18,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: green3,
                              size: 20.0,
                            ),
                            labelText: "confirm password",
                            labelStyle: TextStyle(color: green3),
                            isDense: true,
                            contentPadding: EdgeInsets.all(15)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormDataUser()),
                        );
                        // if (_formKey.currentState!.validate()) {
                        //   AuthController.instance.registrasiUser(
                        //       controller.email.text.trim(),
                        //       controller.password.text.trim());
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: green3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0))),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignIn(),
                                  ));
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: green3),
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
