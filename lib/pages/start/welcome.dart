import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pekato/pages/auth/signin.dart';
import 'package:pekato/pages/auth/signup.dart';
import '../../styles/color.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Center(
            child: SvgPicture.asset("assets/svg/welcome.svg",
                height: height * 0.5)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Selamat Datang di Pekato",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: green3, fontSize: 22.0),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Laporkan semua masalahmu disini, dijamin teratasi sampai tuntas!!",
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignIn()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: greenLight,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20.0)))),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            const VerticalDivider(
              color: Colors.white,
              width: 1.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: greenLite,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(20.0)))),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
