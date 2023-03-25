import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../../../laporan.dart';

class DetailLaporan extends StatefulWidget {
  final Laporan? laporan;
  const DetailLaporan({super.key, required this.laporan});

  @override
  State<DetailLaporan> createState() => _DetailLaporanState();
}

class _DetailLaporanState extends State<DetailLaporan> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("as"),
      ),
    );
  }
}
