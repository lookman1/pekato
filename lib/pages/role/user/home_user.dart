import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pekato/pages/role/user/form/form_laporan.dart';
import 'package:pekato/pages/role/user/pages/notificasi.dart';
import 'package:pekato/pages/role/user/pages/profile.dart';
import 'package:pekato/pages/role/user/pages/riwayat.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/styles/color.dart';

import '../../../controllers/auth_controller.dart';

class HomeUser extends ConsumerStatefulWidget {
  const HomeUser({super.key});

  @override
  ConsumerState<HomeUser> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomeUser> {
  @override
  Widget build(BuildContext context) {
    final sizeContainer = MediaQuery.of(context).size;
    final user = ref.watch(authControllerProvider);
    String nama = user.nama.toString();

    return Scaffold(
      body: ListView(children: [
        SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              height: sizeContainer.height * 0.7,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            iconSize: 30.0,
                            alignment: Alignment.centerRight,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Profile()));
                            },
                            icon: const Icon(
                              Icons.mode_edit_outlined,
                              color: Colors.white,
                            ),
                            hoverColor: green2,
                          ),
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
                        children: [
                          Text(
                            'hai,$nama',
                            style: const TextStyle(
                                fontSize: 23.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          const Text(
                            "Masyarakat",
                            style: TextStyle(color: Colors.white),
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
            ),
          ]),
        ),
      ]),
    );
  }
}
