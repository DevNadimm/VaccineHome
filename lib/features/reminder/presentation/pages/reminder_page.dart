import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_consultations/my_consultations_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_meal_reminders/my_meal_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_medications/my_medications_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_menstrual_cycle_alerts/my_menstrual_cycle_alerts_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_sleep_reminders/my_sleep_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_tests/my_tests_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_water_reminders/my_water_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/dr_consultation_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/meal_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/medication_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/menstrual_cycle_alert_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/pathology_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/physical_exercise_alert_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/sleep_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/water_reminder_page.dart';

class ReminderPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ReminderPage());

  const ReminderPage({super.key});

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  @override
  void initState() {
    _fetchMyMedications();
    _fetchMyConsultations();
    _fetchMyTests();
    _fetchMySleepReminders();
    _fetchMyMealReminders();
    _fetchMyWaterReminders();
    _fetchMyMenstrualCycleAlerts();
    super.initState();
  }

  _fetchMyMedications() => context.read<MyMedicationsBloc>().add(FetchMyMedicationsEvent());
  _fetchMyConsultations() => context.read<MyConsultationsBloc>().add(FetchMyConsultationsEvent());
  _fetchMyTests() => context.read<MyTestsBloc>().add(FetchMyTestsEvent());
  _fetchMySleepReminders() => context.read<MySleepRemindersBloc>().add(FetchMySleepRemindersEvent());
  _fetchMyMealReminders() => context.read<MyMealRemindersBloc>().add(FetchMyMealRemindersEvent());
  _fetchMyWaterReminders() => context.read<MyWaterRemindersBloc>().add(FetchMyWaterRemindersEvent());
  _fetchMyMenstrualCycleAlerts() => context.read<MyMenstrualCycleAlertsBloc>().add(FetchMyMenstrualCycleAlertsEvent());

  @override
  Widget build(BuildContext context) {
    final reminderServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedMedicine02,
        title: "Medication Alert",
        subtitle: "Never miss your medicines on time.",
        onTap: () {
          Navigator.push(context, MedicationReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedStethoscope,
        title: "Dr Consultation Alert",
        subtitle: "Get notified for your appointments.",
        onTap: () {
          Navigator.push(context, DrConsultationReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedTestTube,
        title: "Health Check Alert",
        subtitle: "Lab tests and reports made easy.",
        onTap: () {
          Navigator.push(context, PathologyReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedSleeping,
        title: "Sleep Alert",
        subtitle: "Maintain a healthy sleep schedule.",
        onTap: () {
          Navigator.push(context, SleepReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedOrganicFood,
        title: "Meal Alert",
        subtitle: "Don’t skip your meals on time.",
        onTap: () {
          Navigator.push(context, MealReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedRainDrop,
        title: "Water Alert",
        subtitle: "Stay hydrated throughout the day.",
        onTap: () {
          Navigator.push(context, WaterReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedCalendar01,
        title: "Menstrual Cycle Alert",
        subtitle: "Track and manage your menstrual cycle easily.",
        onTap: () {
          Navigator.push(context, MenstrualCycleAlertPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedYogaMat,
        title: "Physical Exercise Alert",
        subtitle: "Stay active with daily workout reminders.",
        onTap: () {
          Navigator.push(context, PhysicalExerciseAlertPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Self-Care Alert'),
        leading: const AppBarBackBtn()
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: reminderServices.length,
        itemBuilder: (context, index) {
          final service = reminderServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
