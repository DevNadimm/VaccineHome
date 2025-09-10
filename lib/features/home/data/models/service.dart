import 'package:flutter/material.dart';

class Service {
  String name;
  String iconPath;
  VoidCallback onTap;

  Service({
    required this.name,
    required this.iconPath,
    required this.onTap,
  });
}