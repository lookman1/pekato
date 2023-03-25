import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:pekato/controllers/auth_controller.dart';
import 'package:pekato/pages/auth/signup.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/pages/role/administator/admin/home_admin.dart';
import 'package:pekato/pages/role/administator/petugas/home_petugas.dart';
import 'package:pekato/pages/role/user/home_user.dart';
import 'package:pekato/pages/start/welcome.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  bool isSplash = false;

  @override
  void initState() {
    super.initState();
    initData();
    checkLogin();
  }

  Future<void> checkLogin() async {
    await ref.read(authControllerProvider.notifier).checkUsers(context);
  }

  Future<void> initData() async {
    final users =
        await ref.read(authControllerProvider.notifier).getCurrentUsers();
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        isSplash = true;
      });

      if (users != null) {
        if (users.role == 'user') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeUser()));
        } else if (users.role == 'admin') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeAdmin()));
        } else if (users.role == 'petugas') {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePetugas()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Welcome()));
      }
    });
  }

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
