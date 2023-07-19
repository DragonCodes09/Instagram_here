import 'package:flutter/material.dart';
import 'package:insta_flutter/Screens/add_post_screen.dart';
import 'package:insta_flutter/Screens/feed_screen.dart';
import 'package:insta_flutter/Screens/loginScreen.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

const webScreenSize = 600;
 const homeScreenItems=[
  FeedScreen(),
  Text("Search"),
  AddPostScreen(),
  Text("Notification"),
  LoginPage(),
];