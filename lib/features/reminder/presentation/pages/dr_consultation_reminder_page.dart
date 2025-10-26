import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/consultation_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/my_consultations_page.dart';

class DrConsultationReminderPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const DrConsultationReminderPage());

  const DrConsultationReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderModules = [
      SubModule(
        icon: HugeIcons.strokeRoundedAddToList,
        title: "Add Consultation",
        subtitle: "Create a new alert for doctor visits.",
        onTap: () {
          Navigator.push(context, ConsultationFormPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedListView,
        title: "My Consultations",
        subtitle: "View and manage your doctor visit alerts.",
        onTap: () {
          Navigator.push(context, MyConsultationsPage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dr Consultancy Alert'),
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
