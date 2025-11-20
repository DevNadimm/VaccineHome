import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/pages/patients_page.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/pages/vaccine_card_request_page.dart';

class VaccineCardPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineCardPage());

  const VaccineCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vaccineCardServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedStudentCard,
        title: "Vaccine Card Request",
        subtitle: "Apply for your digital vaccine card.",
        onTap: () {
          Navigator.push(context, VaccineCardRequestPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedId,
        title: "Vaccine Card View",
        subtitle: "View and download your vaccine card.",
        onTap: () {
          Navigator.push(context, PatientsPage.route());
        },
      ),

      // ----------------------------
      // ✅ New Sub-Modules Added
      // ----------------------------

      SubModule(
        icon: HugeIcons.strokeRoundedVaccine,
        title: "Private Vaccine Schedule",
        subtitle: "Detailed schedule for private vaccines.",
        onTap: () {
          // TODO: Add route once screen is ready
          // Navigator.push(context, PrivateVaccineSchedulePage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedCalendarLove02,
        title: "EPI Schedule",
        subtitle: "National immunization schedule (EPI).",
        onTap: () {
          // TODO: Add route once screen is ready
          // Navigator.push(context, EpiSchedulePage.route());
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination'),
        leading: const AppBarBackBtn(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: vaccineCardServices.length,
        itemBuilder: (context, index) {
          final service = vaccineCardServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
