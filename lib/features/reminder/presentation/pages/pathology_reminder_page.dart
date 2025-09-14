import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/add_test_page.dart';

class PathologyReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PathologyReminderPage());

  const PathologyReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Test",
        subtitle: "Create a reminder for your pathology/lab tests.",
        onTap: () {
          Navigator.push(context, AddTestPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Tests",
        subtitle: "View and manage your pathology test reminders.",
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pathology Reminder'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
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