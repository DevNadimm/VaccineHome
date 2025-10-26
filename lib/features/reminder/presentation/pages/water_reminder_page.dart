import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_water_reminders_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/water_reminder_form_page_page.dart';

class WaterReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const WaterReminderPage());

  const WaterReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Water Alert",
        subtitle: "Create a new alert to stay hydrated.",
        onTap: () {
          Navigator.push(context, WaterReminderFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Water Alerts",
        subtitle: "View and manage your water intake alerts.",
        onTap: () {
          Navigator.push(context, MyWaterRemindersPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Alert'),
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
