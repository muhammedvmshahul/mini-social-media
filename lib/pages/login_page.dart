import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_button.dart';
import 'package:minimal_social_media/components/my_textfield.dart';
import 'package:minimal_social_media/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // login methode
  void login() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    // try login
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      if(context.mounted) Navigator.pop(context);
      // display any error
    } on FirebaseAuthException catch(e){
      // pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // app name
                  const Text(
                    'MINIMAL',
                    style: TextStyle(fontSize: 50),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // email text field

                  const SizedBox(
                    height: 10,
                  ),
                  // email text field
                  MyTextfield(
                      hintText: 'Email',
                      obscureText: false,
                      controller: emailController),
                  const SizedBox(
                    height: 10,
                  ),
                  // password text field
                  MyTextfield(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // forget password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'forget password',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // sign in button
                  MyButton(onTap: login, text: 'Login'),
                  const SizedBox(
                    height: 25,
                  ),
                  // register section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account? ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            ' Register here',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
