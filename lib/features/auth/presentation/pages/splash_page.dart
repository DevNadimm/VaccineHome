import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/auth/presentation/pages/login_page.dart';
import 'package:vaccine_home/features/navigation/pages/navigation_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));

    final token = await AppPreferences.getAccessToken();
    if (!mounted) return;

    if (token.isNotEmpty) {
      final dioService = serviceLocator<DioService>();
      await dioService.initAuthToken();
      Navigator.pushReplacement(context, NavigationPage.route());
    } else {
      Navigator.pushReplacement(context, LoginPage.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Vaccine Home',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 24,
              color: AppColors.primaryFontColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
