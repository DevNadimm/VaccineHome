import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/navigation/utils/nav_items.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: state,
            type: BottomNavigationBarType.fixed,
            items: bottomNavItems,
            onTap: (index) => context.read<NavigationCubit>().updateIndex(index),
            backgroundColor: AppColors.backgroundColor,
            unselectedItemColor: AppColors.secondaryFontColor,
            selectedItemColor: AppColors.primaryColor,
            unselectedFontSize: 12,
            selectedFontSize: 14,
            iconSize: 22,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
