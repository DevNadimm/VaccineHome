import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/add_medication_page.dart';

class ReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const ReminderPage());

  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Medicine Reminder",
        subtitle: "Never miss your medicines on time.",
        onTap: () {
          Navigator.push(context, AddMedicationPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedHealth,
        title: "Diet Reminder",
        subtitle: "Stay healthy with proper meals.",
        onTap: () {},
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedStethoscope,
        title: "Doctor Consultancy",
        subtitle: "Get notified for your appointments.",
        onTap: () {},
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedTestTube,
        title: "Pathology Reminder",
        subtitle: "Lab tests and reports made easy.",
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder'),
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
        itemCount: reminderServices.length,
        itemBuilder: (context, index) {
          final service = reminderServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
