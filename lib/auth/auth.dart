import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/auth/login_register.dart';
import '../pages/home_page.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // is logged in
          if(snapshot.hasData){
            return  HomePage();
            // is not logged in
          }else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
