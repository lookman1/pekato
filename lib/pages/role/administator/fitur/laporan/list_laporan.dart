import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pekato/pages/role/administator/fitur/laporan/detail_laporan.dart.dart';
import 'package:pekato/styles/color.dart';
import 'package:pekato/model/laporan.dart';

class ListLaporan extends StatefulWidget {
  const ListLaporan({super.key});

  @override
  State<ListLaporan> createState() => _ListLaporanState();
}

class _ListLaporanState extends State<ListLaporan> {
  late Future<QuerySnapshot> _futureLaporan;
  List<Map> _laporanItems = [];

  @override
  void initState() {
    super.initState();
    _futureLaporan = getData();
    _futureLaporan.then((value) {
      setState(() {
        _laporanItems = parseData(value);
      });
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    final data = FirebaseFirestore.instance
        .collection('laporan')
        .where('status', isEqualTo: "terkirim")
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
              'tanggapan_laporan': data['tanggapan'],
            })
        .toList();
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            const Center(
              child: Text(
                "Data Laporan yang Masuk",
                style: TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.bold, color: green4),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Container(
                height: size.height * 1,
                width: size.width * 1,
                child: _laporanItems.isEmpty
                    ? const Center(
                        child: Text("Data Tidak ditemukan"),
                      )
                    : ListViewLaporan(laporanItems: _laporanItems),
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
                              const Text(
                                "Pengirim : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                              Text(
                                item['nama_laporan'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Tempat : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                              Text(
                                item['tempat_laporan'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Laporan : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                              Text(
                                item['jenis_laporan'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Tanggal : ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                              Text(
                                item['tanggal_laporan'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                      Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: HexColor('72E191'),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailLaporan(
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
