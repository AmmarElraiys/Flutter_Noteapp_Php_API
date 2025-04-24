import 'package:flutter/material.dart';

class TextbuttonLoginSignupWidget extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const TextbuttonLoginSignupWidget({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
