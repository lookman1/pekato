import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:pekato/pages/role/user/form/form_data_user.dart';
import '../../../../components/session.dart';
import '../../../../controllers/auth_controller.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () async {
                try {
                  await ref
                      .read(authControllerProvider.notifier)
                      .logout(context);
                  deleteSession();
                } on FirebaseAuthException {
                  return;
                }
              },
              child: Text("Logout")),
        ]),
      ),
    );
  }
}
