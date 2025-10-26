import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/meal_reminder_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_meal_reminders_page.dart';

class MealReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MealReminderPage());

  const MealReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Meal Alert",
        subtitle: "Create a new alert for your meals.",
        onTap: () {
          Navigator.push(context, MealReminderFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Meal Alerts",
        subtitle: "View and manage your meal alerts.",
        onTap: () {
          Navigator.push(context, MyMealRemindersPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Alert'),
        leading: const AppBarBackBtn(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: reminderModules.length,
        itemBuilder: (context, index) {
          final module = reminderModules[index];
          return SubModuleCard(subModule: module);
        },
      ),
    );
  }
}
