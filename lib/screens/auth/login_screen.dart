import 'package:flutter/material.dart';
import 'package:library_management_system/screens/auth/signup_screen.dart';
import 'package:library_management_system/services/auth_services.dart';
import 'package:library_management_system/utils/navigations.dart';
import 'package:library_management_system/widgets/buttons.dart';
import 'package:library_management_system/widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Center(
                  child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset('images/logo.png'),
              )),
              const Text(
                'Login To Your Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
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
                  await AuthServices.signIn(
                    context: context,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  setState(() {
                    emailController.clear();
                    passwordController.clear();
                    FocusScope.of(context).unfocus();
                  });
                },
                title: "Login",
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  navigateToPage(context, const SignUpScreen());
                },
                child: const Text(
                  "Don't have an Account? SignUp",
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
