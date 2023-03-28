import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:pekato/controllers/laporan_controller.dart';
import 'package:pekato/styles/color.dart';

class FormLaporan extends ConsumerStatefulWidget {
  const FormLaporan({super.key});

  @override
  ConsumerState<FormLaporan> createState() => _FormLaporanState();
}

class _FormLaporanState extends ConsumerState<FormLaporan> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nik = TextEditingController();
  TextEditingController tempat = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController isi = TextEditingController();
  String _selectedOption = 'Bencana alam';
  DateTime? _selectedDate;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String foto = '';

  Future getFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uplaodFile() async {
    final path = 'Bukti Laporan/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapsot = await uploadTask!.whenComplete(() {});

    final urlImg = await snapsot.ref.getDownloadURL();
    foto = urlImg.toString();
  }

  @override
  Widget build(BuildContext context) {
    final sizeContainer = MediaQuery.of(context).size;
    final users = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: greenLight,
      body: ListView(children: [
        SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Container(
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
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0, top: 15.0),
                    child: Text(
                      "Form Laporan",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Text(
                    "Masukan Data Laporan Anda",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: sizeContainer.height * 0.81,
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
                        "Nik",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: nik,
                        cursorColor: green4,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          disabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0, color: green3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          hintText: '${users.nik}',
                          hintStyle: TextStyle(fontSize: 15.0, color: green3),
                          isDense: true, // Added this
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        style: const TextStyle(fontSize: 15.0),
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
                      TextFormField(
                        controller: tempat,
                        cursorColor: green4,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: green3, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0, color: green3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
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
                              border: Border.all(color: green4),
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
                        "Tanggal Kejadian",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: green4),
                      ),
                      TextFormField(
                        cursorColor: green4,
                        controller: tanggal,
                        readOnly: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: green3, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0, color: green3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          hintText: "masukan tanggal kejadian",
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onTap: () async {
                          _selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          if (_selectedDate != null) {
                            tanggal.text =
                                DateFormat('dd/MM/yyyy').format(_selectedDate!);
                          }
                        },
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
                      TextFormField(
                        controller: isi,
                        cursorColor: green4,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: green3, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0, color: green3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
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
                        width: sizeContainer.width * 1,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: green4),
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Column(
                              children: [
                                pickedFile == null
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 35.0),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: getFile,
                                                iconSize: 35.0,
                                                color: green4,
                                                icon: const Icon(Icons.image),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            "klick disini",
                                            style: TextStyle(
                                                color: green4, fontSize: 15.0),
                                          )
                                        ],
                                      )
                                    : Expanded(
                                        child: Image.file(
                                          File(pickedFile!.path!),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Center(
                          child: SizedBox(
                            width: 120.0,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await uplaodFile();
                                    try {
                                      await ref
                                          .read(laporanControllerProvider
                                              .notifier)
                                          .kirimLaporan(
                                              context,
                                              nik.text,
                                              tempat.text,
                                              _selectedOption,
                                              tanggal.text,
                                              isi.text,
                                              foto);
                                      print('aaa $foto');
                                    } catch (e) {}
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: greenLight,
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
