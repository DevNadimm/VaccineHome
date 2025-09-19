import 'package:flutter/material.dart';

class Service {
  String name;
  IconData icon;
  VoidCallback onTap;

  Service({
    required this.name,
    required this.icon,
    required this.onTap,
  });
}