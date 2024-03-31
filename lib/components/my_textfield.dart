import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final TextEditingController controller ;
  final bool obscure;
  final String text;

  const MyTextField({super.key, required this.obscure, required this.text, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 25),
      padding:const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(12)
      ),
      child: TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
          ),
      ),
    );
  }
}