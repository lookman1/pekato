import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/pages/role/user/fitur/form/form_data_user.dart';
import '../../../../../components/session.dart';
import '../../../../../controllers/auth_controller.dart';
import '../../../../../styles/color.dart';

class ProfileAdministator extends ConsumerStatefulWidget {
  const ProfileAdministator({super.key});

  @override
  ConsumerState<ProfileAdministator> createState() =>
      _ProfileAdministatorState();
}

class _ProfileAdministatorState extends ConsumerState<ProfileAdministator> {
  @override
  Widget build(BuildContext context) {
    final sizeContext = MediaQuery.of(context).size;
    final users = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: bgGreen,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: sizeContext.height * 0.33,
            child: Stack(
              children: [
                // Widget pertama
                Container(
                  height: sizeContext.height * 0.2,
                  width: sizeContext.width * 1,
                  decoration: const BoxDecoration(
                      color: greenLight,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(180.0))),
                ),
                Positioned(
                  left: 30.0,
                  top: 20.0,
                  child: Row(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: const BoxDecoration(
                            color: bgbutton,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0))),
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
                        width: 98.0,
                      ),
                      const Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                // Widget kedua yang akan ditempatkan di atas widget pertama
                Positioned(
                  top: 80,
                  left: 115,
                  child: Container(
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        maxRadius: 90,
                        backgroundImage: AssetImage('assets/img/piks.jpg'),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              ('${users.nama}'),
              style: const TextStyle(
                  color: green4, fontSize: 29.0, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: green4, width: 2.0)),
                        hintText: '${users.role}'.toUpperCase(),
                        hintStyle: const TextStyle(
                            color: green4,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(
                          Icons.settings_accessibility,
                          color: green4,
                          size: 35.0,
                        ),
                        suffixIcon: const Icon(
                          Icons.settings_accessibility_rounded,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    enabled: false,
                    decoration: InputDecoration(
                        disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: green4, width: 2.0)),
                        hintText: '${users.telp}',
                        hintStyle: const TextStyle(
                            color: green4,
                            fontSize: 23.0,
                            fontWeight: FontWeight.w400),
                        prefixIcon: const Icon(
                          Icons.local_phone_outlined,
                          color: green4,
                          size: 35.0,
                        ),
                        suffixIcon: const Icon(
                          Icons.settings_accessibility_rounded,
                          color: Colors.white,
                        )),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130.0,
                height: 45.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      backgroundColor: green2,
                    ),
                    onPressed: () async {
                      try {
                        await ref
                            .read(authControllerProvider.notifier)
                            .logout(context);
                        deleteSession();
                      } on FirebaseAuthException {
                        return;
                      }
                    },
                    child: const Text(
                      "Log Out",
                      style: TextStyle(fontSize: 17.0),
                    )),
              ),
              const SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: 130.0,
                height: 45.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      backgroundColor: greenLight,
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormDataUser()));
                    },
                    child:
                        const Text("Edit", style: TextStyle(fontSize: 17.0))),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
