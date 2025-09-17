import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/navigation/utils/nav_items.dart';
import 'package:vaccine_home/features/navigation/widgets/custom_bottom_nav_bar.dart';

class NavigationPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const NavigationPage());
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
