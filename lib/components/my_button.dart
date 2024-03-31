
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final  Function onTap;
  final String title;

   MyButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 25),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text(title, style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700
        ),),
      ),
    );
  }
}
