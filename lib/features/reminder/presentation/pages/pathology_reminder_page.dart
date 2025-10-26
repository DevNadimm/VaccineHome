import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/test_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_tests_page.dart';

class PathologyReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PathologyReminderPage());

  const PathologyReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Test",
        subtitle: "Create a alert for your pathology/lab tests.",
        onTap: () {
          Navigator.push(context, TestFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Tests",
        subtitle: "View and manage your pathology test alerts.",
        onTap: () {
          Navigator.push(context, MyTestsPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pathology Alert'),
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