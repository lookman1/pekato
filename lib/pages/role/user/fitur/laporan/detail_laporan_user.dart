import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pekato/model/laporan.dart';
import 'package:pekato/pages/role/user/fitur/form/form_laporan.dart';
import 'package:pekato/pages/role/user/fitur/laporan/edit_laporan.dart';

import '../../../../../styles/color.dart';

class DetailLaporanUser extends StatefulWidget {
  const DetailLaporanUser({super.key, required this.laporan});
  final Map<dynamic, dynamic> laporan;

  @override
  State<DetailLaporanUser> createState() => _DetailLaporanUserState();
}

class _DetailLaporanUserState extends State<DetailLaporanUser> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: bgGreen,
      body: SafeArea(
          child: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: bgbutton,
                      boxShadow: [
                        BoxShadow(
                            color: green1, blurRadius: 1.0, spreadRadius: 1.0)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
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
                  const Center(
                    child: Text(
                      "Detail Laporan",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                          color: green4),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                        color: bgbutton,
                        boxShadow: [
                          BoxShadow(
                              color: green1, blurRadius: 1.0, spreadRadius: 1.0)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    child: Center(
                      child: IconButton(
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditLaporan(
                                        laporan: widget.laporan,
                                      )));
                        },
                        icon: const Icon(
                          Icons.mode_edit_outlined,
                          color: Colors.white,
                        ),
                        hoverColor: green2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: size.height * 0.78,
                width: size.width * 1,
                decoration: BoxDecoration(
                    color: greenLight,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 2.0,
                          spreadRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.circular(25.0)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 30.0),
                    child: Container(
                        height: 200.0,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                            color: bgbutton,
                            border:
                                Border.all(color: Colors.white, width: 1.0)),
                        child: Image.network(
                          '${widget.laporan['foto_laporan']}',
                        )),
                  ),

                  //DATA
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Pengirim     ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 2.0,
                                              spreadRadius: 5.0)
                                        ],
                                        fontSize: 22.0),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "NIK     ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0,
                                      shadows: [
                                        BoxShadow(
                                            color: green1,
                                            blurRadius: 1.0,
                                            spreadRadius: 1.0)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Tempat     ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22.0),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Laporan     ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22.0),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Tanggal     ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22.0),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ]),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ': ${widget.laporan['nama_laporan']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  ': ${widget.laporan['nik_laporan']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  ': ${widget.laporan['tempat_laporan']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  ': ${widget.laporan['jenis_laporan']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  ': ${widget.laporan['tanggal_laporan']}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22.0),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text(
                                " Isi   :",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22.0),
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              height: 200,
                              width: size.width * 0.63,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  color: bgbutton,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  '${widget.laporan['isi_laporan'].toString()}.',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 180,
                              height: 30,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 2.0,
                                        spreadRadius: 1.0)
                                  ],
                                  color: bgbutton,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Status",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      ': ${widget.laporan['status_laporan'].toString()}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ])),
    );
  }
}
