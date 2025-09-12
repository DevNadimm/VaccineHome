import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/themes/theme.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/navigation/pages/navigation_page.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/intake_toggle_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => IntakeToggleCubit()),
        BlocProvider(create: (_) => TimeListCubit()),
      ],
      child: MaterialApp(
        title: 'Vaccine Home',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const NavigationPage(),
      ),
    );
  }
}
