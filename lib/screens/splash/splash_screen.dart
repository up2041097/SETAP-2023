import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_management_system/screens/auth/login_screen.dart';
import 'package:library_management_system/utils/navigations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      navigateToPage(context, const LoginScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset('images/logo.png'),
          ))
        ],
      ),
    );
  }
}
