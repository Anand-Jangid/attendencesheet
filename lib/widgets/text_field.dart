import 'package:flutter/material.dart';

class TextFielD extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  const TextFielD({Key? key,
    required this.hintText,
    required this.controller,
    required this.textInputType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w900),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),

      ),
    );
  }
}
