import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';

OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryColor,
    side: const BorderSide(color: AppColors.primaryColor, width: 2),
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    textStyle: GoogleFonts.poppins(
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        height: 1.2,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);
