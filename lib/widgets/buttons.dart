import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  const PrimaryButton({Key? key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
