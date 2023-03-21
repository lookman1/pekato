import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pekato/pages/home/user/home_user.dart';
import 'package:pekato/styles/color.dart';

class FormDataUser extends StatefulWidget {
  const FormDataUser({super.key});

  @override
  State<FormDataUser> createState() => _FormDataUserState();
}

class _FormDataUserState extends State<FormDataUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
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
                    fontSize: 25.0, fontWeight: FontWeight.bold, color: green4),
              ),
            ),
            Center(child: SvgPicture.asset('assets/svg/dataPerson.svg')),

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
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        "Masukan Data Anda",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: green4),
                      ),
                    ),
                    Form(
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
                          const TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Masukan Nama Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: TextStyle(fontSize: 15.0),
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
                          const TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Masukan NIK Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: TextStyle(fontSize: 15.0),
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
                          const TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Masukan Alamat Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: TextStyle(fontSize: 15.0),
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
                          const TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Masukan No. Telepon Anda",
                              isDense: true, // Added this
                              contentPadding: EdgeInsets.all(10),
                            ),
                            style: TextStyle(fontSize: 15.0),
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
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeUser(),
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: green2,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0))),
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
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
