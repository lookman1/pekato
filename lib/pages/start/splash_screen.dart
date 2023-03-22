import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:pekato/pages/auth/signup.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/pages/role/admin/home_admin.dart';
import 'package:pekato/pages/role/petugas/home_petugas.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  bool splash = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/img/at.png",
      nextScreen: const Welcome(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 400,
    );
  }
}
