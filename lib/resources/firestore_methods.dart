import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insta_flutter/models/posts.dart';
import 'package:insta_flutter/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
      String description,
      String username,
      String profImage,
      String uid,
      Uint8List file
      ) async {
    String res="Some Error Occured";
    try{
      String photoURL = await StorageMethods().uploadImageToStorage("Posts", file, true);
      String postID =const Uuid().v1();
      Post post = Post(
          description: description,
          datePublished: DateTime.now(),
          postURL: photoURL,
          profImage: profImage,
          likes: [],
          uid: uid,
          username: username,
          postID: postID
      );
      _firestore.collection('posts').doc(postID).set(post.toJson());
      res="Success";
    }catch(e){
      res=e.toString();
    }
    return res;
  }
}