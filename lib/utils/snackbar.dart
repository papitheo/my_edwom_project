import 'package:flutter/material.dart';

openIconSnackBar(context, String text, Widget icon) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Row(
      children: [
        icon,
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        )
      ],
    ),
    duration: const Duration(milliseconds: 2500),
  ));
}
