import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pekato/pages/role/administator/admin/fitur/tambah_petugas.dart';
import 'package:pekato/pages/role/administator/fitur/data_user/data_masyarakat.dart';
import 'package:pekato/pages/role/administator/fitur/laporan/list_laporan.dart';
import 'package:pekato/pages/role/administator/fitur/laporan/list_pekerjaan.dart';
import 'package:pekato/pages/role/user/fitur/form/form_laporan.dart';
import 'package:pekato/pages/role/user/fitur/notificasi.dart';
import 'package:pekato/pages/role/user/fitur/laporan/riwayat.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/styles/color.dart';

import '../../../../components/session.dart';
import '../../../../controllers/auth_controller.dart';
import '../fitur/profile/profile_admin.dart';
import 'fitur/notifikasi_admin.dart';

class HomeAdmin extends ConsumerStatefulWidget {
  const HomeAdmin({super.key});

  @override
  ConsumerState<HomeAdmin> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeAdmin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeContainer = MediaQuery.of(context).size;
    final users = ref.watch(authControllerProvider);
    return Scaffold(
      body: ListView(children: [
        SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: sizeContainer.height * 0.37,
              decoration: const BoxDecoration(
                  color: greenLight,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(200.0))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileAdministator()));
                                },
                                icon: const Icon(
                                  Icons.mode_edit_outlined,
                                  color: Colors.white,
                                ),
                                hoverColor: greenLight,
                              ),
                            ),
                          ),
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
                                alignment: Alignment.centerRight,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NotifikasiAdmin()));
                                },
                                icon: const Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                ),
                                hoverColor: greenLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: CircleAvatar(
                          maxRadius: 80,
                          backgroundImage: AssetImage('assets/img/piks.jpg'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            ('${users.nama}'),
                            style: const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            ('${users.role}'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          )
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
                          color: greenLight),
                      child: SizedBox(
                          height: 130.0,
                          width: 170.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 15.0),
                                      child: Text(
                                        "Data \nUser",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Icon(
                                      Icons.supervised_user_circle_outlined,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    SizedBox(
                                      width: 1.0,
                                    )
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "Semua data user\nada disini",
                                    textAlign: TextAlign.center,
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
                              builder: (context) => const TambahPetugas()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: greenLight),
                      child: SizedBox(
                          height: 130.0,
                          width: 170.0,
                          child: Padding(
                            padding: const EdgeInsets.all(.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 15.0),
                                        child: Text(
                                          "Tambah \nPetugas",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.0,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Icon(
                                        Icons.person_add_outlined,
                                        color: Colors.white,
                                        size: 50.0,
                                      ),
                                      SizedBox(
                                        width: 12.0,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Text(
                                      "Form tambah akun petugas",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17.0),
                                    ),
                                  ),
                                ]),
                          )),
                    ),
                  ),
                ],
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
                              builder: (context) => const ListLaporan()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: greenLight),
                      child: SizedBox(
                          height: 130.0,
                          width: 170.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 15.0),
                                      child: Text(
                                        "List \nlaporan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Icon(
                                      Icons.insert_chart_outlined_outlined,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "Semua laporan ada disini",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17.0),
                                  ),
                                ),
                              ])),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListPekerjaan()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: greenLight),
                      child: SizedBox(
                          height: 130.0,
                          width: 170.0,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 15.0, left: 10.0),
                                      child: Text(
                                        "List \nPekerjaan",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.list,
                                      color: Colors.white,
                                      size: 40.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    "Daftar Kerjaan ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17.0),
                                  ),
                                ),
                              ])),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListPekerjaan()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: greenLight),
                    child: SizedBox(
                        height: 60.0,
                        width: 230.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      "Generate laporan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.file_download_outlined,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  )
                                ],
                              ),
                            ])),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
