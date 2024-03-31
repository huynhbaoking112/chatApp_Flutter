import 'package:chatapp/HandleFireBase/authFireBase.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRegister extends StatefulWidget {

  final Function togglePage;

   MyRegister({super.key, required this.togglePage});

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();


  Future signUp() async {
      final instanceAuth = Provider.of<FireAuth>(context, listen: false);
      
   if(checkMatch()){
    try {
      if(emailController.text != '' && passwordController.text != ''){
          await instanceAuth.signUp(emailController.text, passwordController.text);
        }
    } catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Something went wrong please try again!'),
        ),);
    }
   }else{
    showDialog(context: context, builder: (context) => AlertDialog(
          title: Text('Something went wrong please try again!'),
        ),);
   }
  }

  bool checkMatch(){
    if(passwordController.text != confirmPasswordController.text){
      return false;
    }else{
      return true;
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
        const Text("Welcome CHATAPP", style: TextStyle(
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

         //Confirm Password Field
        MyTextField(obscure: true, text: "ConfirmPassword...", controller: confirmPasswordController,),

        const SizedBox(height: 25,),

        //Sign Up button
        MyButton(onTap: signUp, title: "Sign Up",),

       const SizedBox(height: 25,),

        //Register
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Have an account? ", style: TextStyle(
              fontWeight: FontWeight.w400,
            ),),
            GestureDetector(
              onTap: (){widget.togglePage();} ,
              child: Text("Loggin now", style: TextStyle(
                fontWeight: FontWeight.w700
              ),),
            )
          ],
        )

      ],),
    );
  }
}