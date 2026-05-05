import 'package:flutter/material.dart';

class StopperButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const StopperButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
