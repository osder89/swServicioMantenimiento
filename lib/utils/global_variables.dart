import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'package:swfotografia/screens/home_Screen.dart';

import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/group_screend.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/shipment_screen.dart';

const webScreenSize = 600;

List<Widget> HomeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const GroupScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
