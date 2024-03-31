import 'package:chatapp/pages/login.dart';
import 'package:chatapp/pages/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool isLogin = true;
  
  void togglePage(){
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginPage(togglePage: togglePage);
    }else{
      return MyRegister(togglePage: togglePage);
    }
  }
}