import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/services/app_update_service.dart';
import 'package:vaccine_home/core/services/dio_service.dart';
import 'package:vaccine_home/core/services/service_locator.dart';
import 'package:vaccine_home/features/auth/presentation/pages/welcome_page.dart';
import 'package:vaccine_home/features/home/presentation/blocs/advertisement/advertisement_bloc.dart';
import 'package:vaccine_home/features/navigation/pages/navigation_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _getAdvertisements();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isAndroid && !kDebugMode) {
        AppUpdateService.checkForUpdate(context);
      }
    });

    _navigateNext();
  }

  void _getAdvertisements() => context.read<AdvertisementBloc>().add(FetchAdvertisementsEvent());

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await AppPreferences.getAccessToken();
    if (!mounted) return;

    if (token.isNotEmpty) {
      final dioService = serviceLocator<DioService>();
      await dioService.initAuthToken();
      Navigator.pushReplacement(context, NavigationPage.route());
    } else {
      Navigator.pushReplacement(context, WelcomePage.route());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          AssetPaths.appLogo,
                          height: 100,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Vaccine Sheba',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 24,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Powered By Section
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text(
                                'Powered by',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  AssetPaths.poweredByBanner,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
