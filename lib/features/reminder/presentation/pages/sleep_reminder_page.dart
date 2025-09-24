import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_sleep_reminders_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/sleep_reminder_form_page.dart';

class SleepReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const SleepReminderPage());

  const SleepReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Sleep Reminder",
        subtitle: "Create a new reminder for your sleep schedule.",
        onTap: () {
          Navigator.push(context, SleepReminderFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Sleep Reminders",
        subtitle: "View and manage your sleep reminders.",
        onTap: () {
          Navigator.push(context, MySleepRemindersPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Reminder'),
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
