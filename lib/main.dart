import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pekato/firebase_options.dart';
import 'package:pekato/model/pages/role/administator/fitur/laporan/detail_laporan.dart.dart';
import 'package:pekato/model/pages/role/administator/fitur/laporan/list_laporan.dart';
import 'package:pekato/model/pages/role/user/home_user.dart';
import 'package:pekato/model/pages/role/user/fitur/profile.dart';
import 'package:pekato/model/pages/start/splash_screen.dart';
import 'components/session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await getSession();
  runApp(const ProviderScope(child: Pekato()));
}

class Pekato extends StatelessWidget {
  const Pekato({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Splash());
  }
}
