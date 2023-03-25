import 'package:flutter/material.dart';
import 'package:pekato/styles/color.dart';

class DetailLaporan extends StatefulWidget {
  const DetailLaporan({super.key, required this.laporan});
  final Map<dynamic, dynamic> laporan;

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              width: size.width * 1,
              decoration: BoxDecoration(
                  color: greenLight, borderRadius: BorderRadius.circular(20.0)),
              child: Text(
                widget.laporan['nama_laporan'].toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
