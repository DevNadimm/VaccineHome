import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/features/about/presentation/pages/about_us_page.dart';
import 'package:vaccine_home/features/home/presentation/pages/home_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/profile_page.dart';

List<Widget> bottomNavScreens = [
  const HomePage(),
  const AboutUsPage(),
  const ProfilePage(),
];

const List<BottomNavigationBarItem> bottomNavItems = [
  BottomNavigationBarItem(
    icon: Icon(HugeIcons.strokeRoundedHome01),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(HugeIcons.strokeRoundedFavourite),
    label: 'About Us',
  ),
  BottomNavigationBarItem(
    icon: Icon(HugeIcons.strokeRoundedUser),
    label: 'Profile',
  ),
];
