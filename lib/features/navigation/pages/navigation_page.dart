import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../utils/nav_items.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, index) {
        return Scaffold(
          body: bottomNavScreens[index],
          bottomNavigationBar: const CustomBottomNavBar(),
        );
      },
    );
  }
}
