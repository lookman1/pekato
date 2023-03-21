import 'package:flutter/material.dart';
import 'package:pekato/pages/home/admin/pages/data_laporan.dart';
import 'package:pekato/pages/home/admin/pages/list_laporan.dart';
import 'package:pekato/pages/home/admin/pages/notifikasi_admin.dart';
import 'package:pekato/pages/home/admin/pages/profile_admin.dart';
import 'package:pekato/styles/color.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileAdmin()));
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
                                            const NotifikasiAdmin()));
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
                            builder: (context) => const DataLaporan()));
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
            )
          ]),
        ),
      ]),
    );
  }
}
