import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/medication_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_medications_page.dart';

class MedicationReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MedicationReminderPage());

  const MedicationReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Medication",
        subtitle: "Create a new alert for your medicines.",
        onTap: () {
          Navigator.push(context, MedicationFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Medications",
        subtitle: "View and manage your saved alerts.",
        onTap: () {
          Navigator.push(context, MyMedicationsPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Alert'),
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
