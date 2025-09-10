import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_home/app.dart';

void main() {
  return runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}
