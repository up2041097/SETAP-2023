import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final IconData? icon;
  final Function(String v)? onChange;
  const CustomTextInput({Key? key, this.controller, this.title, this.icon, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange ?? (v) {},
      controller: controller!,
      decoration: InputDecoration(
        hintText: title!,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      ),
    );
  }
}
