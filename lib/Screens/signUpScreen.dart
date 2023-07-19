import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_flutter/Screens/loginScreen.dart';
import 'package:insta_flutter/resources/auth_methods.dart';
import 'package:insta_flutter/utils/colours.dart';
import 'package:insta_flutter/utils/utils.dart';

import '../widgets/text_fields_input.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _IsLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
  void goToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
void signingIn() async{

    String R = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _IsLoading = true;
    });
    if(R!='success'){
      showSnackBar(R, context);
    }
    else{
      //
    }
    setState(() {
      _IsLoading = false;
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 1,
              ),
              // SvgPicture.asset('assets/images/ic_instagram.svg', color: primaryColor,height: 64,),
              Image.asset(
                'assets/images/Logo.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Dragon Instagram',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              //image
              const SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundImage: MemoryImage(_image!),
                          // backgroundColor: Colors.white54,
                        )
                      : const CircleAvatar(
                          radius: 40,
                          // backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fsketchfab.com%2Ftags%2Fcaricatura&psig=AOvVaw3mZTyGvSVfzvmxpzKEYuH8&ust=1686631088580000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCLjh8sj0vP8CFQAAAAAdAAAAABAE'),
                          backgroundColor: Colors.white54,
                          // backgroundImage: NetworkImage('https://img.freepik.com/free-icon/user_318-159711.jpg'),
                        ),
                  Positioned(
                      bottom: -10,
                      left: 40,
                      child: IconButton(
                        onPressed: () {
                          selectImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo,
                          color: Colors.amber,
                          size: 18,
                        ),

                      ))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textEditingController: _usernameController,
                  textInputType: TextInputType.text,
                  hintText: 'Enter Your Username'),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Enter Your Email Address'),
              //Email
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                textInputType: TextInputType.text,
                hintText: 'Enter Your Password',
                IsPass: true,
              ),
              //Pass
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _bioController,
                textInputType: TextInputType.text,
                hintText: 'Enter Your Bio',
                IsPass: true,
              ),
              //Pass
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  signingIn();
                  goToLogin();
                },
                child: Container(
                  child: _IsLoading? const Center(child: CircularProgressIndicator(color: primaryColor,),):Text('Enter Dungeon'),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)))),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
