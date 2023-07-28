import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/screens/auth/login_screen.dart';

class LogOutScreen extends StatelessWidget {
  const LogOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoAlertDialog(
            title: const Text("LogOut!"),
            content: const Text("Do You want to LogOut?"),
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context!).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                  },
                  child: const Text("Yes")),
              CupertinoActionSheetAction(onPressed: () {}, child: const Text("No")),
            ],
          )
        ],
      ),
    );
  }
}
