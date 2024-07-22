import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/helper/helper_functions.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController conformPwController = TextEditingController();

  // register method
  void register() async {
    // show loading screen
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // make sure passwords match
    if (passwordController.text != conformPwController.text) {
      // pop loading circle
      Navigator.pop(context);
      // show error to the user
      displayMessageToUser('Password is not match!', context);
    }
    // if password matching
    else {
      Future<void> createUserDocument(UserCredential? userCredential)async{
        if(userCredential != null && userCredential.user != null){
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.email).set({
            'email' : userCredential.user!.email,
            'username' : usernameController.text,
          });
        }
      }
      // try create user
      try {
        // create user
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        // create user document add to firestore
         createUserDocument(userCredential);

        // pop loading circle
       if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
      // create a user document and collect them in firestore


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
                  MyTextfield(
                      hintText: 'user name',
                      obscureText: false,
                      controller: usernameController),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextfield(
                      hintText: 'Email',
                      obscureText: false,
                      controller: emailController),
                  const SizedBox(
                    height: 15,
                  ),
                  // password text field
                  MyTextfield(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController),
                  const SizedBox(
                    height: 10,
                  ),

                  MyTextfield(
                      hintText: 'conform password',
                      obscureText: false,
                      controller: conformPwController),
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
                  MyButton(onTap: register, text: 'Register'),
                  const SizedBox(
                    height: 25,
                  ),
                  // register section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You have an Account? ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            ' Login here',
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
