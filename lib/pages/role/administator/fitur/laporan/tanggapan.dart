import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import '../../../../../controllers/laporan_controller.dart';
import '../../../../../styles/color.dart';

class Tanggapan extends ConsumerStatefulWidget {
  const Tanggapan({super.key, required this.idLaporan});
  final String? idLaporan;

  @override
  ConsumerState<Tanggapan> createState() => _TanggapanState();
}

class _TanggapanState extends ConsumerState<Tanggapan> {
  TextEditingController tanggapan = TextEditingController();
  late Future<QuerySnapshot> _futureUser;
  final _formKey = GlobalKey<FormState>();
  List<Map> _userItems = [];

  @override
  void initState() {
    super.initState();
    _futureUser = getData();
    _futureUser.then((value) {
      setState(() {
        _userItems = parseData(value);
      });
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() async {
    final currentuser = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: currentuser!.uid)
        .get();
    return data;
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listItems = listDocs
        .map((data) => {
              'id_user': data['uid'],
              'nama_user': data['nama'],
              'noTelp_user': data['telp'],
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
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  const SizedBox(
                    width: 30.0,
                  ),
                  const Center(
                    child: Text(
                      "Form Tanggapan",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                          color: green4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Container(
                  height: size.height * 0.3,
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
                      padding: const EdgeInsets.all(7.0),
                      child: SingleChildScrollView(
                        // child: Container(
                        //   height: 80.0,
                        //   width: size.width * 1,
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(20.0))),
                        child: _userItems.isEmpty
                            ? const Center(
                                child: Text(
                                  "Belum ada laporan yang ditanggapi",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : ListViewLaporan(userItems: _userItems),
                        // ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: TextFormField(
                                cursorColor: Colors.white,
                                controller: tanggapan,
                                maxLines: 6,
                                keyboardType: TextInputType.text,
                                style: TextStyle(color: Colors.white),
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return 'Tanggapan tidak boleh kosong';
                                  }
                                  return null;
                                }),
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 3.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 3.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2.0, color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    hintText: "Masukan Tanggapan anda",
                                    hintStyle:
                                        TextStyle(fontSize: 18, color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.white),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(15)),
                              ),
                            ),
                          ],
                        ))
                  ]),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: SizedBox(
                      width: 120.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await ref
                                  .read(laporanControllerProvider.notifier)
                                  .kirimTanggapan(
                                      context,
                                      widget.idLaporan.toString(),
                                      tanggapan.text);
                            } catch (e) {}
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenLight,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                          ),
                          child: const Text("Kirim")),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewLaporan extends StatelessWidget {
  const ListViewLaporan({
    super.key,
    required List<Map> userItems,
  }) : _userItems = userItems;

  final List<Map> _userItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _userItems.length,
        itemBuilder: (context, index) {
          Map item = _userItems[index];
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                  color: greenLight, borderRadius: BorderRadius.circular(20.0)),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
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
                                      "Nama",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),
                                    Text(
                                      "No Telepon",
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
                                    ': ${item['nama_user']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.0),
                                  ),
                                  Text(
                                    ': ${item['noTelp_user']}',
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
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
