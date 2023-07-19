import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Add image to Firebase Storage
  Future<String> uploadImageToStorage(String chindName, Uint8List file,bool IsPost) async {
   Reference _ref =  _storage.ref().child(chindName).child(_auth.currentUser!.uid);
   if(IsPost){
     String id=const Uuid().v1();
     _ref=_ref.child(id);

   }
   UploadTask uploadTask= _ref.putData(file);
   TaskSnapshot snap = await uploadTask;
   String downloadURL = await snap.ref.getDownloadURL();
   return downloadURL;
  }
}