import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/menstrual_cycle_alert_form_page.dart';

class MenstrualCycleAlertPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MenstrualCycleAlertPage());

  const MenstrualCycleAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menstrualModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Cycle Alert",
        subtitle: "Record your latest menstrual cycle details.",
        onTap: () {
          Navigator.push(context, MenstrualCycleAlertFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Cycle Alerts",
        subtitle: "View and manage your menstrual cycle alerts.",
        onTap: () {
          // Navigator.push(context, MyMenstrualCycleAlertsPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menstrual Cycle Alert'),
        leading: const AppBarBackBtn(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: menstrualModules.length,
        itemBuilder: (context, index) {
          final module = menstrualModules[index];
          return SubModuleCard(subModule: module);
        },
      ),
    );
  }
}
