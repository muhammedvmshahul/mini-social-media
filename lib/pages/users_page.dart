import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_ListTile.dart';

import '../components/my_back_button.dart';
import '../helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            // if any error
            if (snapshot.hasError) {
              displayMessageToUser('something went wrong', context);
            }
            // loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            }
            // user not get
            if (snapshot.data == null) {
              return const Text('no data');
            }
            // get all users
            final users = snapshot.data!.docs;
            return SafeArea(
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
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: ListView.builder(
                        itemCount: users.length,
                          itemBuilder: (context, index){
                          var user = users[index];
                          String username = user['username'];
                          String email = user['email'];
                         return MyListtile(title: username, subtitle: email);
                          }

                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
