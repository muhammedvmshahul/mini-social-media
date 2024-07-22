import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
this database stores posts that users have published in the app
its stored collection called 'Posts' in Firebase

Each post contain
- a message
- user or email
- timestamp

 */

class FirestoreDatabase {
// current logged in users
  User? user = FirebaseAuth.instance.currentUser;

// get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

// post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now()
    });
  }

// read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp')
        .snapshots();
    return postsStream;
  }
}
