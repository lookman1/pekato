import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../../../../components/session.dart';
import '../../../../controllers/auth_controller.dart';

class ProfilePetugas extends ConsumerStatefulWidget {
  const ProfilePetugas({super.key});

  @override
  ConsumerState<ProfilePetugas> createState() => _ProfilePetugasState();
}

class _ProfilePetugasState extends ConsumerState<ProfilePetugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
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
        ],
      )),
    );
  }
}
