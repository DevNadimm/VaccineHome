import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/themes/theme.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/pin_verification/pin_verification_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/set_new_password/set_new_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/splash_page.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/advertisement/advertisement_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/add_consultation/add_consultation_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/add_medication/add_medication_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/add_test/add_test_bloc.dart';
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
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => EditProfileBloc()),
        BlocProvider(create: (_) => ChangePasswordBloc()),
        BlocProvider(create: (_) => AddMedicationBloc()),
        BlocProvider(create: (_) => AddConsultationBloc()),
        BlocProvider(create: (_) => AddTestBloc()),
        BlocProvider(create: (_) => ForgotPasswordBloc()),
        BlocProvider(create: (_) => PinVerificationBloc()),
        BlocProvider(create: (_) => SetNewPasswordBloc()),
        BlocProvider(create: (_) => AdvertisementBloc()),
      ],
      child: MaterialApp(
        title: 'Vaccine Home',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SplashPage(),
      ),
    );
  }
}
