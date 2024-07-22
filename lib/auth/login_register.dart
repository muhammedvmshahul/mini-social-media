import 'package:flutter/material.dart';
import 'package:minimal_social_media/pages/login_page.dart';
import 'package:minimal_social_media/pages/register_page.dart';


class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // initially show here login page
  bool showLoginPage = true;
  // toggle b/w register or login page
    void toglePages(){
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }
  @override
  Widget build(BuildContext context) {
      if(showLoginPage){
        return LoginPage(onTap: toglePages,);
      }else{
        return RegisterPage(onTap: toglePages,);
      }
  }
}
