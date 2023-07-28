import 'package:flutter/material.dart';
import 'package:library_management_system/screens/auth/login_screen.dart';
import 'package:library_management_system/services/auth_services.dart';

import '../../utils/navigations.dart';
import '../../widgets/buttons.dart';
import '../../widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(
                  child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset('images/logo.png'),
              )),
              const Text(
                'Register Yourself',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextInput(
                title: "Full Name",
                icon: Icons.person,
                controller: usernameController,
              ),
              const SizedBox(height: 20),
              CustomTextInput(
                title: "Email",
                icon: Icons.email,
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextInput(
                title: "Password",
                icon: Icons.lock,
                controller: passwordController,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                onPressed: () async {
                  await AuthServices.signUp(
                    context: context,
                    username: usernameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  setState(() {
                    usernameController.clear();
                    emailController.clear();
                    passwordController.clear();
                    FocusScope.of(context).unfocus();
                  });
                },
                title: "SignUp",
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  navigateToPage(context, const LoginScreen());
                },
                child: const Text(
                  "Already have an Account? Login",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
