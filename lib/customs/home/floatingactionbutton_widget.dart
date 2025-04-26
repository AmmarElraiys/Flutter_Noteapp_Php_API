import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final String tooltip;

  const FloatingActionButtonWidget({
    super.key,
    required this.onPressed,
    this.backgroundColor = Colors.orangeAccent,
    this.icon = Icons.add,
    this.tooltip = 'Yeni Not Ekle',
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: Icon(icon, size: 28, color: Colors.white),
      tooltip: tooltip,
    );
  }
}
