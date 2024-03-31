
import 'package:chatapp/HandleFireBase/authFireBase.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  final Function togglePage;

   LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future signIn() async {
  final instanceAuth = Provider.of<FireAuth>(context, listen: false);
      try {
        if(emailController.text != '' && passwordController.text != ''){
          await instanceAuth.signIn(emailController.text, passwordController.text);
        }
      } catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Something went wrong please try again!'),
        ),);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        //Image Icon
        const Center(child:  Icon(Icons.message, size: 100,)),

        const SizedBox(height: 25,),

        //TextWelcom
        const Text("Welcome back you've been missed!", style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20
        ),),

        const SizedBox(height: 25,),
        
        //Email Field
        MyTextField(obscure: false, text: "Email...", controller: emailController,),

        const SizedBox(height: 25,),

        //Password Field
        MyTextField(obscure: true, text: "Password...", controller: passwordController,),

        const SizedBox(height: 25,),

        //Sign In button
        MyButton(onTap: signIn, title: "Sign In",),

       const SizedBox(height: 25,),

        //Register
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Not a member? ", style: TextStyle(
              fontWeight: FontWeight.w400,
            ),),
            GestureDetector(
              onTap: (){widget.togglePage();} ,
              child: Text("Register now", style: TextStyle(
                fontWeight: FontWeight.w700
              ),),
            )
          ],
        )

      ],),
    );
  }
}