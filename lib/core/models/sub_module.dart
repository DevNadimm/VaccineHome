import 'package:flutter/material.dart';

class SubModule {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  SubModule({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
