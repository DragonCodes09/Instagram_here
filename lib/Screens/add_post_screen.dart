import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_flutter/resources/firestore_methods.dart';
import 'package:insta_flutter/utils/colours.dart';
import 'package:insta_flutter/utils/utils.dart';

class AddPostScreen extends StatefulWidget{
  const AddPostScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddPostScreenState();
}
class _AddPostScreenState extends State<AddPostScreen>{
  String P="";
  String username="";
  String uid="";
  bool _isLoading = false ;
  // String picURL="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void postImage(String uid,
  String username,
  String profImage) async {
    setState(() {
      _isLoading=true;
    });
    try{
      String res = await FirestoreMethods().uploadPost(_descriptionController.text, username, profImage, uid, _file!);
      if(res=="Success"){
        setState(() {
          _isLoading=false;
        });
        showSnackBar('Posted !', context);
        setState(() {
          _file=null;
        });
      }else{
        setState(() {
          _isLoading=false;
        });
        showSnackBar('res', context);
      }
    }catch(e){
      showSnackBar(e.toString(), context);
    }
  }
  void getData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Fellows').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      // print(snap.data());
      P=(snap.data() as Map<String,dynamic>)['picURL'];
      username=(snap.data() as Map<String,dynamic>)['Username'];
      uid=(snap.data() as Map<String,dynamic>)['Uid'];
    });
  }
  Uint8List? _file ;
  final TextEditingController _descriptionController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }
  void _selectImage(BuildContext context) async {
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Create a Post"),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: const Text("Take a photo"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.camera);
              setState(() {
                _file=file;
              });
            },
          ),SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: const Text("Take from Gallery"),
            onPressed: () async {
              Navigator.of(context).pop();
              Uint8List file = await pickImage(ImageSource.gallery);
              setState(() {
                _file=file;
              });
            },
          ),SimpleDialogOption(
            padding: EdgeInsets.all(20),
            child: const Text("Cancel"),
            onPressed: (){
              Navigator.of(context).pop();
            }
          ),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // late M.User? user;
    // setState(() {
    //   // user=_user;
    // });
    return _file == null ?
        Center(
          child: IconButton(onPressed: () => _selectImage(context),
            icon: const Icon(Icons.upload),
          ),
        )

     : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: (){
            setState(() {
              _file=null;
            });
          },
        ),
        title: const Text("Post To:"),
        actions: [
          TextButton(
              onPressed: () => postImage(uid, username, P),
              // onPressed: (){
              //   print("Printed");
              //   print("$username");
              //   print("$uid");
              //   print("$P");
              // },
              child: const Text("Post",
                style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 16),
              )
          )
        ],
      ),
      body: Column(
        children: [
          _isLoading? const LinearProgressIndicator() : Container(),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                // child: Text(P),
                // backgroundColor: Colors.blueAccent,
                backgroundImage: NetworkImage(P),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.45,
                child: TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: "Write a Caption...",
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      )
                    ),
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ],
      ),
    );
  }

}