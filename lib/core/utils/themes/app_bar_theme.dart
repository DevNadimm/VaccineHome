import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: AppColors.backgroundColor,
  foregroundColor: AppColors.primaryFontColor,
  scrolledUnderElevation: 0,
  elevation: 0,
  centerTitle: false,
  titleTextStyle: GoogleFonts.poppins(
    textStyle: const TextStyle(
      fontSize: 22,
      color: AppColors.primaryFontColor,
      fontWeight: FontWeight.bold,
    ),
  )
);
