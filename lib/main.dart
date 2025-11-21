import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_home/app.dart';
import 'package:vaccine_home/core/services/notification_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  //
  // await NotificationService.instance.initialize();

  return runApp(const MyApp());
}
