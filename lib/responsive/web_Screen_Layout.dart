import 'package:flutter/material.dart';
import 'package:insta_flutter/models/user.dart';
import 'package:insta_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

class WebScreenLayout extends StatelessWidget{
  const WebScreenLayout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    // User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(child: Text("user!.username")),
    );
  }
}