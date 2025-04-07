import 'package:animals/view/screens/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../../view/screens/Listings_screens/add_listing_screen.dart';
import '../presentation/app_colors.dart';



List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
  const BottomNavigationBarItem(icon: Icon(Icons.explore),label: 'Explore'),
  const BottomNavigationBarItem(icon: Icon(Icons.add_business),label: 'Sell'),
  const BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile'),
];

List<Widget> screens =  [
  Container(color: AppColor.successColor,),
  Container(color: AppColor.warningColor,),
  AddListingScreen(),
  UserProfileScreen(),
];






