import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pekato/pages/role/administator/fitur/laporan/detail_laporan.dart.dart';
import 'package:pekato/pages/role/user/fitur/laporan/detail_laporan_user.dart';
import 'package:pekato/pages/role/user/fitur/laporan/edit_laporan.dart';
import 'package:pekato/styles/color.dart';
import 'package:pekato/model/laporan.dart';

class Riwayat extends StatefulWidget {
  const Riwayat({super.key});

  @override
  State<Riwayat> createState() => _RiwayatState();
}

class _RiwayatState extends State<Riwayat> {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('laporan');
  late Future<QuerySnapshot> _futureLaporan;
  late Future<QuerySnapshot> _futureLaporanProses;
  late Future<QuerySnapshot> _futureLaporanTuntas;
  List<Map> _laporanItems = [];
  List<Map> _laporanProsesItems = [];
  List<Map> _laporanTuntasItems = [];
  QuerySnapshot<Map<String, dynamic>>? dataLaporan;

  @override
  void initState() {
    super.initState();
    _futureLaporan = getData();
    _futureLaporanProses = getDataProses();
    _futureLaporanTuntas = getDataTuntas();

    _futureLaporan.then((value) {
      setState(() {
        _laporanItems = parseData(value);
      });
    });
    _futureLaporanProses.then((value) {
      setState(() {
        _laporanProsesItems = parseData(value);
      });
    });
    _futureLaporanTuntas.then((value) {
      setState(() {
        _laporanTuntasItems = parseData(value);
      });
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection('laporan')
        .where('uid', isEqualTo: currentuser!.uid)
        .where('status', isEqualTo: "terkirim")
        .get();
    return data;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataTuntas() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection('laporan')
        .where('uid', isEqualTo: currentuser!.uid)
        .where('status', isEqualTo: "tuntas")
        .get();
    return data;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataProses() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection('laporan')
        .where('uid', isEqualTo: currentuser!.uid)
        .where('status', isEqualTo: "proses")
        .get();
    return data;
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((data) => {
              'nama_laporan': data['nama'],
              'nik_laporan': data['nik'],
              'tempat_laporan': data['tempat'],
              'jenis_laporan': data['jenis'],
              'tanggal_laporan': data['tanggal'],
              'isi_laporan': data['isi'],
              'foto_laporan': data['foto'],
              'status_laporan': data['status'],
              'id_laporan': data['idlaporan'],
            })
        .toList();
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgGreen,
      body: SafeArea(
          child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                        color: bgbutton,
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
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
                    width: 30.0,
                  ),
                  const Center(
                    child: Text(
                      "Daftar Laporan",
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: green4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Center(
              child: Text(
                "Riwayat Laporan",
                style: TextStyle(
                    fontSize: 25.0, fontWeight: FontWeight.bold, color: green4),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 355.0,
                  width: size.width * 1,
                  decoration: const BoxDecoration(
                      color: bgGreen,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                            spreadRadius: 1.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: _laporanItems.isEmpty
                      ? const Center(
                          child: Text(
                            "Anda Belum Mengimkan Laporan !",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListViewLaporan(laporanItems: _laporanItems),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  "Laporan Tertanggapi",
                  style: TextStyle(
                      color: green4,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 355.0,
                  width: size.width * 1,
                  decoration: const BoxDecoration(
                      color: bgGreen,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                            spreadRadius: 1.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: _laporanItems.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada laporan yang ditanggapi",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListViewLaporanProses(
                          laporanProsesItems: _laporanProsesItems),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  "Laporan Tuntas",
                  style: TextStyle(
                      color: green4,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 355.0,
                  width: size.width * 1,
                  decoration: const BoxDecoration(
                      color: bgGreen,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1.0,
                            spreadRadius: 1.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: _laporanItems.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada laporan yang tuntas",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        )
                      : ListViewLaporanTuntas(
                          laporanTuntasItems: _laporanTuntasItems),
                ),
              ),
            ),
          ],
        ),
      ])),
    );
  }
}

class ListViewLaporan extends StatelessWidget {
  const ListViewLaporan({
    super.key,
    required List<Map> laporanItems,
  }) : _laporanItems = laporanItems;

  final List<Map> _laporanItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _laporanItems.length,
        itemBuilder: (context, index) {
          Map item = _laporanItems[index];
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              decoration: BoxDecoration(
                  color: greenLight, borderRadius: BorderRadius.circular(20.0)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Pengirim",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Tempat",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Laporan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                  ]),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ': ${item['nama_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['tempat_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['jenis_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: HexColor('72E191'),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailLaporanUser(
                                            laporan: _laporanItems[index],
                                          )));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 45.0,
                            ),
                          ))
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

class ListViewLaporanProses extends StatelessWidget {
  const ListViewLaporanProses({
    super.key,
    required List<Map> laporanProsesItems,
  }) : _laporanProsesItems = laporanProsesItems;

  final List<Map> _laporanProsesItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _laporanProsesItems.length,
        itemBuilder: (context, index) {
          Map item = _laporanProsesItems[index];
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              decoration: BoxDecoration(
                  color: greenLight, borderRadius: BorderRadius.circular(20.0)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Pengirim",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Tempat",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Laporan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                  ]),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ': ${item['nama_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['tempat_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['jenis_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: HexColor('72E191'),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailLaporanUser(
                                            laporan: _laporanProsesItems[index],
                                          )));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 45.0,
                            ),
                          ))
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

class ListViewLaporanTuntas extends StatelessWidget {
  const ListViewLaporanTuntas({
    super.key,
    required List<Map> laporanTuntasItems,
  }) : _laporanTuntasItems = laporanTuntasItems;

  final List<Map> _laporanTuntasItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _laporanTuntasItems.length,
        itemBuilder: (context, index) {
          Map item = _laporanTuntasItems[index];
          return Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              decoration: BoxDecoration(
                  color: greenLight, borderRadius: BorderRadius.circular(20.0)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Pengirim",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Tempat",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "Laporan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                  ]),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ': ${item['nama_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['tempat_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['jenis_laporan']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: HexColor('72E191'),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailLaporanUser(
                                            laporan: _laporanTuntasItems[index],
                                          )));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 45.0,
                            ),
                          ))
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
