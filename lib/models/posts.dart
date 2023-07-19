import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  late final String description;
  late final String uid;
  late final String postID;
  late final String username;
  late final datePublished;
  late final String postURL;
  late final String profImage;
  final likes;

  Post( {
    required this.description,
    required this.datePublished,
    required this.postURL,
    required this.profImage,
    required this.likes,
    required this.uid,
    required this.username,
    required this.postID
  });
  Map<String,dynamic> toJson() => {
    'username' : username,
    'uid': uid,
    'description':description,
    'datePublished' : datePublished,
    'postURL': postURL,
    'postID': postID,
    'profImage' : profImage,
    'likes' : likes,
  };
  static Post fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    return Post(
      username: snapshot['Username'],
      uid: snapshot['Uid'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      postURL: snapshot['postURL'],
      profImage: snapshot['profImage'],
      likes: snapshot['likes'],
        postID: snapshot['postID']
    );
  }
}