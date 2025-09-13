import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/add_consultation_page.dart';

class DrConsultancyReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const DrConsultancyReminderPage());

  const DrConsultancyReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Consultation",
        subtitle: "Create a new reminder for doctor visits.",
        onTap: () {
          Navigator.push(context, AddConsultationPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Consultations",
        subtitle: "View and manage your doctor visit reminders.",
        onTap: () {
          // Navigator.push(context, ConsultancyListPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dr Consultancy Reminder'),
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
