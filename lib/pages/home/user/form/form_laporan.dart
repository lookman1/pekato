import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pekato/styles/color.dart';

class FormLaporan extends StatefulWidget {
  const FormLaporan({super.key});

  @override
  State<FormLaporan> createState() => _FormLaporanState();
}

class _FormLaporanState extends State<FormLaporan> {
  final _formKey = GlobalKey<FormState>();
  String _selectedOption = 'Bencana alam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: green2,
      body: ListView(children: [
        SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Masukan Data Laporan Anda",
                  style: TextStyle(
                      color: green4,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        "Nama",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "masukan nama anda",
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "Tempat Kejadian",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "masukan nama tempat",
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "Jenis Kejadian",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      SizedBox(
                        height: 35.0,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: green2),
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                focusColor: Colors.white,
                                dropdownColor: Colors.white,
                                icon: const Icon(Icons.arrow_drop_down),
                                value: _selectedOption,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedOption = newValue!;
                                  });
                                },
                                items: <String>[
                                  'Bencana alam',
                                  'Kriminal',
                                  'Masalah fasilitas',
                                  'Keresahan'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "Isi Laporan",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      const TextField(
                        maxLines: 6,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                          hintText: "Masukan laporan Anda",
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(10),
                        ),
                        style: TextStyle(fontSize: 15.0),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Text(
                        "Foto",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      SizedBox(
                        height: 147.0,
                        width: 350.0,
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(color: green2)),
                          child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "click disini",
                                style: TextStyle(color: green2),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: SizedBox(
                            width: 120.0,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: green2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                ),
                                child: const Text("Kirim")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ]),
    );
  }
}
