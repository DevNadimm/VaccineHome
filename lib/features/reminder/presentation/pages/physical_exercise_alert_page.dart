import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_physical_exercise_alerts_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/physical_exercise_alert_form_page.dart';

class PhysicalExerciseAlertPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PhysicalExerciseAlertPage());

  const PhysicalExerciseAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exerciseModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Exercise Alert",
        subtitle: "Set reminders for your daily workouts or activities.",
        onTap: () {
          Navigator.push(context, PhysicalExerciseAlertFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Exercise Alerts",
        subtitle: "View and manage your physical exercise alerts.",
        onTap: () {
          Navigator.push(context, MyPhysicalExerciseAlertsPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Physical Exercise Alert'),
        leading: const AppBarBackBtn(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: exerciseModules.length,
        itemBuilder: (context, index) {
          final module = exerciseModules[index];
          return SubModuleCard(subModule: module);
        },
      ),
    );
  }
}
