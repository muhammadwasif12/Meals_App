import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }
}
