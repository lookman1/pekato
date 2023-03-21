import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pekato/firebase_options.dart';
import 'package:pekato/pages/auth/auth_repo.dart';
import 'package:pekato/pages/start/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // .then((value) => Get.put(AuthRepo()));
  runApp(const Pekato());
}

class Pekato extends StatelessWidget {
  const Pekato({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
