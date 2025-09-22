import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class AppBarBackBtn extends StatelessWidget {
  final VoidCallback? onBack;
  const AppBarBackBtn({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBack ?? () => Navigator.pop(context),
      icon: const Icon(
        HugeIcons.strokeRoundedArrowLeft01,
        size: 32,
        color: AppColors.primaryFontColor,
      ),
    );
  }
}
