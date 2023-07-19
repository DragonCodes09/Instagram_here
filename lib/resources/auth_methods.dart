import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_flutter/models/user.dart' as model;
import 'package:insta_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  Future<model.User> getUserDetails() async{
    User current = _auth.currentUser!;
    // print("This is CURRENT = $current");
    DocumentSnapshot snap = await _store.collection('Fellows').doc(current.uid).get();
    // print("This is SNAP");
    // print(snap.data());
    return model.User.fromSnap(snap);
  }
   Future<String> signUpUser({
     required String email,
     required String password,
     required String username,
     required String bio,
     required Uint8List file,
   }) async {
    String R="Some error occured :(";
    try{
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file!=null){

        //Register USER
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // Storing Data
        print(cred.user!.uid);
        String picURL = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        model.User user = model.User(
          username : username,
          password: password,
          uid:cred.user!.uid,
          email:email,
          bio : bio,
          picURL : picURL,
          followers : [],
          following : [],
        );

        await _store.collection('Fellows').doc(cred.user!.uid).set(user.toJson());
        R = "Success";
      }
    } on FirebaseAuthException catch(err){
      if(err.code == 'invalid-email'){
        R = "The email format is not correct";
      }
    }
    catch(err){
      R=err.toString() ;
    }
    return R;
  }
  Future<String> loginUser({
    required String email,
    required String pass
})async{
   String R = "Some error occoured";
   try{
      if(email.isNotEmpty||pass.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        R="Success";
      }else{
        R="Please enter all the fields";
      }
   }catch(error){
     R=error.toString();
   }
   return R;
  }
}