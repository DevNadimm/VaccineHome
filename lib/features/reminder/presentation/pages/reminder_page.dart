import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/dr_consultation_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/meal_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/medication_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/pathology_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/sleep_reminder_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/water_reminder_page.dart';

class ReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ReminderPage());

  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedMedicine02,
        title: "Medication Reminder",
        subtitle: "Never miss your medicines on time.",
        onTap: () {
          Navigator.push(context, MedicationReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedStethoscope,
        title: "Dr Consultation Reminder",
        subtitle: "Get notified for your appointments.",
        onTap: () {
          Navigator.push(context, DrConsultationReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedTestTube,
        title: "Pathology Reminder",
        subtitle: "Lab tests and reports made easy.",
        onTap: () {
          Navigator.push(context, PathologyReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedSleeping,
        title: "Sleep Reminder",
        subtitle: "Maintain a healthy sleep schedule.",
        onTap: () {
          Navigator.push(context, SleepReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedOrganicFood,
        title: "Meal Reminder",
        subtitle: "Don’t skip your meals on time.",
        onTap: () {
          Navigator.push(context, MealReminderPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedRainDrop,
        title: "Water Reminder",
        subtitle: "Stay hydrated throughout the day.",
        onTap: () {
          Navigator.push(context, WaterReminderPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
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
