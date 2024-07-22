
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/components/my_ListTile.dart';
import 'package:minimal_social_media/components/my_Post_Button.dart';
import 'package:minimal_social_media/components/my_drawer.dart';
import 'package:minimal_social_media/components/my_textfield.dart';

import '../database/firestore.dart';


class HomePage extends StatelessWidget {
   HomePage({super.key});
   // fireStore access
   final FirestoreDatabase database = FirestoreDatabase();

// controller
 final TextEditingController newPostController = TextEditingController();

 // post message
  void postMessage(){
    // ony post something in the text field
    if(newPostController.text.isNotEmpty){
      String message = newPostController.text;
      database.addPost(message);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      appBar: AppBar(
        title: const Text('W A L L'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // text field user to type
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                // text
                Expanded(
                  child: MyTextfield(
                      hintText:'say something...',
                      obscureText:false,
                      controller:newPostController
                  ),
                ),
                MyPostButton(
                  onTap:postMessage,
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          //posts
          StreamBuilder(stream: database.getPostsStream(), builder: (context,snapshot){
            // show loading circle
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // check for error
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            // get all posts
            final posts = snapshot.data!.docs;

            // no data ?
                if(snapshot.data == null || posts.isEmpty){
                  return const Center(
                    child: Text('No posts'),
                  );
                }
            // return as a list
            return Expanded(
                child:ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context,index){
                // get each individual posts
                  final post = posts[index];
                // get data from each post
                String message = post['PostMessage'];
                String email = post['UserEmail'];
                // Timestamp timestamp = post['TimeStamp'];
                  // return us a list tile
                  return MyListtile(title: message, subtitle:email,);

            }) );
          })
        ],
      ),
    );
  }
}
