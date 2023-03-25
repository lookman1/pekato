import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pekato/pages/role/administator/fitur/data_user/data_masyarakat.dart';
import 'package:pekato/pages/role/administator/fitur/laporan/list_laporan.dart';
import 'package:pekato/pages/role/user/fitur/form/form_laporan.dart';
import 'package:pekato/pages/role/user/fitur/notificasi.dart';
import 'package:pekato/pages/role/user/fitur/profile.dart';
import 'package:pekato/pages/role/user/fitur/laporan/riwayat.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/styles/color.dart';

import '../../../../components/session.dart';
import '../../../../controllers/auth_controller.dart';

class HomePetugas extends ConsumerStatefulWidget {
  const HomePetugas({super.key});

  @override
  ConsumerState<HomePetugas> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomePetugas> {
  Future<void> getData() async {
    await ref.read(authControllerProvider.notifier).getUser();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeContainer = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(children: [
        SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: sizeContainer.height * 0.4,
              decoration: const BoxDecoration(
                  color: green2,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(200.0))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
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
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundImage: AssetImage('assets/img/piks.jpg'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'PETUGAS',
                            style: TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataMasyarakat()));
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
                                      vertical: 15.0, horizontal: 15.0),
                                  child: Text(
                                    "Data Masyarakat",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "Data diri user\nmasyarakat",
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
                              builder: (context) => const ListLaporan()));
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
                                    "List Laporan",
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
                                    "Data laporan \ndari masyarakat",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17.0),
                                  ),
                                )
                              ])),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: green3,
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
                      style: TextStyle(fontSize: 18.0),
                    )),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
