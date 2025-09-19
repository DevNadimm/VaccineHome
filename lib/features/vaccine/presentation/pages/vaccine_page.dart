import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/online_vaccine_appoinment_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/vaccine_request_page.dart';

class VaccinePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccinePage());

  const VaccinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vaccineServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedHealth,
        title: "Vaccine List with Details",
        subtitle: "Browse vaccines and learn more about them.",
        onTap: () {},
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedAddSquare,
        title: "Vaccine Request",
        subtitle: "Request a vaccine for yourself or family.",
        onTap: () {
          Navigator.push(context, VaccineRequestPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedCalendar02,
        title: "Online Vaccine Appointment",
        subtitle: "Book your vaccine appointments online.",
        onTap: () {
          Navigator.push(context, OnlineVaccineAppointmentPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedBulb,
        title: "Vaccine Recommendation",
        subtitle: "Get personalized vaccine recommendations.",
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 36,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: vaccineServices.length,
        itemBuilder: (context, index) {
          final service = vaccineServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
