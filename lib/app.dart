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
import 'package:vaccine_home/features/home/presentation/blocs/popup_banner/popup_banner_bloc.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/blocs/mental_well_being/mental_well_being_bloc.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/home/presentation/blocs/advertisement/advertisement_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/change_password/change_password_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/edit_profile/edit_profile_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/faq/faq_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/rating_cubit.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/vaccine_order_history/vaccine_order_history_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/consultation_form/consultation_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/duration_type_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/intake_toggle_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/meal_reminder_form/meal_reminder_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/medication_form/medication_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/menstrual_cycle_alert_form/menstrual_cycle_alert_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_consultations/my_consultations_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_meal_reminders/my_meal_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_medications/my_medications_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_menstrual_cycle_alerts/my_menstrual_cycle_alerts_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_sleep_reminders/my_sleep_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_tests/my_tests_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_water_reminders/my_water_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/sleep_reminder_form/sleep_reminder_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/test_form/test_form_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/time_list_cubit.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/water_reminder_form/water_reminder_form_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/image_selection_cubit.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/online_vaccine_appointment/online_vaccine_appointment_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_order/vaccine_order_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_product/vaccine_product_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_recommentdation/vaccine_recommendation_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/patients/patients_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/vaccine_card_request/vaccine_card_request_bloc.dart';
import 'package:vaccine_home/main.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 🔹 Core Navigation
        BlocProvider(create: (_) => NavigationCubit()),

        // 🔹 Auth
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => RegisterBloc()),
        BlocProvider(create: (_) => ForgotPasswordBloc()),
        BlocProvider(create: (_) => PinVerificationBloc()),
        BlocProvider(create: (_) => SetNewPasswordBloc()),

        // 🔹 Profile
        BlocProvider(create: (_) => EditProfileBloc()),
        BlocProvider(create: (_) => ChangePasswordBloc()),
        BlocProvider(create: (_) => FeedbackBloc()),
        BlocProvider(create: (_) => RatingCubit()),
        BlocProvider(create: (_) => FAQBloc()),
        BlocProvider(create: (_) => VaccineOrderHistoryBloc()),

        // 🔹 Reminder / My Records
        BlocProvider(create: (_) => IntakeToggleCubit()),
        BlocProvider(create: (_) => TimeListCubit()),
        BlocProvider(create: (_) => MedicationFormBloc()),
        BlocProvider(create: (_) => ConsultationFormBloc()),
        BlocProvider(create: (_) => TestFormBloc()),
        BlocProvider(create: (_) => MyConsultationsBloc()),
        BlocProvider(create: (_) => MyMedicationsBloc()),
        BlocProvider(create: (_) => MyTestsBloc()),
        BlocProvider(create: (_) => MealReminderFormBloc()),
        BlocProvider(create: (_) => SleepReminderFormBloc()),
        BlocProvider(create: (_) => WaterReminderFormBloc()),
        BlocProvider(create: (_) => MyMealRemindersBloc()),
        BlocProvider(create: (_) => MyWaterRemindersBloc()),
        BlocProvider(create: (_) => MySleepRemindersBloc()),
        BlocProvider(create: (_) => MenstrualCycleAlertFormBloc()),
        BlocProvider(create: (_) => MyMenstrualCycleAlertsBloc()),
        BlocProvider(create: (_) => DurationTypeCubit()),

        // 🔹 Vaccine
        BlocProvider(create: (_) => VaccineOrderBloc()),
        BlocProvider(create: (_) => VaccineCardRequestBloc()),
        BlocProvider(create: (_) => VaccineProductBloc()),
        BlocProvider(create: (_) => OnlineVaccineAppointmentBloc()),
        BlocProvider(create: (_) => VaccineRecommendationBloc()),
        BlocProvider(create: (_) => ImageSelectionCubit()),

        // 🔹 Home
        BlocProvider(create: (_) => AdvertisementBloc()),
        BlocProvider(create: (_) => NotificationBloc()),
        BlocProvider(create: (_) => PopupBannerBloc()),

        // 🔹 Mental Well Being
        BlocProvider(create: (_) => MentalWellBeingBloc()),

        // 🔹 Vaccine Card
        BlocProvider(create: (_) => PatientsBloc()),
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
