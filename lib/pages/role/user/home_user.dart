import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pekato/pages/role/user/form/form_laporan.dart';
import 'package:pekato/pages/role/user/pages/notificasi.dart';
import 'package:pekato/pages/role/user/pages/profile.dart';
import 'package:pekato/pages/role/user/pages/riwayat.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/styles/color.dart';

import '../../../components/session.dart';
import '../../../controllers/auth_controller.dart';

class HomeUser extends ConsumerStatefulWidget {
  const HomeUser({super.key});

  @override
  ConsumerState<HomeUser> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Profile()));
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: green2,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircleAvatar(
                            maxRadius: 30,
                            backgroundImage: AssetImage('assets/img/piks.jpg'),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Luqman",
                              style: TextStyle(
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              "Masyarakat",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: IconButton(
                              iconSize: 30.0,
                              alignment: Alignment.centerRight,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Notifikasi()));
                              },
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Colors.white,
                              ),
                              hoverColor: green2,
                            ),
                          ),
                        )
                      ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FormLaporan()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: green2),
                    child: SizedBox(
                        height: 130.0,
                        width: 170.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 15.0),
                                child: Text(
                                  "Pelakat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  "Laporkan semua \nmasalahmu disini",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                              )
                            ])),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Riwayat()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: green2),
                    child: SizedBox(
                        height: 130.0,
                        width: 170.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 15.0),
                                child: Text(
                                  "Riwayat",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Text(
                                  "Semua laporanmu \nada disini",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                              )
                            ])),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await ref
                        .read(authControllerProvider.notifier)
                        .logout(context);
                    deleteSession();
                  } on FirebaseAuthException {
                    AnimatedSnackBar.rectangle(
                      'Logout Failed',
                      '',
                      type: AnimatedSnackBarType.error,
                      mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    );
                  }
                },
                child: Text("Logout"))
          ]),
        ),
      ]),
    );
  }
}
