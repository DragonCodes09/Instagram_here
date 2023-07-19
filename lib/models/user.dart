import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  late final String email;
  late final String uid;
  late final String password;
  late final String username;
  late final String bio;
  late final String picURL;
  late final List followers;
  late final List following;

  User({
    required this.email,
    required this.uid,
    required this.password,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
    required this.picURL,
});
  Map<String,dynamic> toJson() => {
    'Username' : username,
    'Uid': uid,
    'Email':email,
    'Bio' : bio,
    'Followers': [],
    'Following': [],
    'photoURL' : picURL,
    'password' : password,
  };
  static User fromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    return User(
      username: snapshot['Username'],
      uid: snapshot['Uid'],
      password: snapshot['password'],
      email: snapshot['Email'],
      bio: snapshot['Bio'],
      picURL: snapshot['photoURL'],
      following: snapshot['Following'],
      followers: snapshot['Followers'],
    );
  }
}