import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

// current logged in user
 final User? currentUser = FirebaseAuth.instance.currentUser;

  // Future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    if(currentUser != null){
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.email)
          .get();

    }else{
      throw Exception('user not logged');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context,snapshot){
          // loading
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // error
            else if(snapshot.hasError){
              return Text('error : ${snapshot.error}');
          }
          // data
            else if(snapshot.hasData){
              // extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const Padding(
                      padding:  EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          MyBackButton(),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(25)
                      ),
                        padding: const EdgeInsets.all(25),
                        child: const Icon(Icons.person,size: 65,),
                    ),
                    const SizedBox(height: 25,),
                    Text(user!['username'],style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Text(user['email'],style: const  TextStyle(fontSize: 18,fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
            );
          }
            else{
              return const Text('no data');
          }

        },
      ),
    );
  }
}
