import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:pekato/pages/auth/signup.dart';
import 'package:pekato/pages/start/welcome.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

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
