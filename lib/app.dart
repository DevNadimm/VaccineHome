import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/themes/theme.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/pin_verification/pin_verification_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/register/register_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/blocs/set_new_password/set_new_password_bloc.dart';
import 'package:vaccine_home/features/auth/presentation/pages/splash_page.dart';
import 'package:vaccine_home/features/home/presentation/blocs/notification/notification_bloc.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/blocs/mental_well_being/mental_well_being_bloc.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/home/presentation/blocs/advertisement/advertisement_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/faq/faq_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/rating_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/consultation_form/consultation_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/intake_toggle_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/medication_form/medication_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_consultations/my_consultations_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_medications/my_medications_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_tests/my_tests_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/test_form/test_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/online_vaccine_appointment/online_vaccine_appointment_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_order/vaccine_order_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_product/vaccine_product_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/vaccine_card_request/vaccine_card_request_bloc.dart';
import 'package:vaccine_home/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Navigation
        BlocProvider(create: (_) => NavigationCubit()),

        // Auth
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => ForgotPasswordBloc()),
        BlocProvider(create: (_) => PinVerificationBloc()),
        BlocProvider(create: (_) => SetNewPasswordBloc()),

        // Profile
        BlocProvider(create: (_) => EditProfileBloc()),
        BlocProvider(create: (_) => ChangePasswordBloc()),

        // Reminder / My Records
        BlocProvider(create: (_) => IntakeToggleCubit()),
        BlocProvider(create: (_) => TimeListCubit()),
        BlocProvider(create: (_) => MedicationFormBloc()),
        BlocProvider(create: (_) => ConsultationFormBloc()),
        BlocProvider(create: (_) => TestFormBloc()),
        BlocProvider(create: (_) => MyConsultationsBloc()),
        BlocProvider(create: (_) => MyMedicationsBloc()),
        BlocProvider(create: (_) => MyTestsBloc()),

        // Vaccine
        BlocProvider(create: (_) => VaccineOrderBloc()),
        BlocProvider(create: (_) => VaccineCardRequestBloc()),
        BlocProvider(create: (_) => VaccineProductBloc()),
        BlocProvider(create: (_) => OnlineVaccineAppointmentBloc()),

        // Home / Advertisement / Notification
        BlocProvider(create: (_) => AdvertisementBloc()),
        BlocProvider(create: (_) => NotificationBloc()),

        // Mental Well Being
        BlocProvider(create: (_) => MentalWellBeingBloc()),

        // Feedback
        BlocProvider(create: (_) => FeedbackBloc()),
        BlocProvider(create: (_) => RatingCubit()),

        // FAQ
        BlocProvider(create: (_) => FAQBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Vaccine Home',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SplashPage(),
      ),
    );
  }
}
