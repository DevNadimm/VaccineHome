import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/pages/wellness_insights_page.dart';

class MentalWellBeingPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MentalWellBeingPage());

  const MentalWellBeingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mentalWellBeingServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedBrain03,
        title: "Wellness Insights",
        subtitle: "Practical tips and advice to boost your mental well-being daily.",
        onTap: () {
          Navigator.push(context, WellnessInsightsPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedVideo01,
        title: "Wellness Visuals",
        subtitle: "Visuals to support mental health and calm your mind.",
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Well Being'),
        leading: const AppBarBackBtn()
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: mentalWellBeingServices.length,
        itemBuilder: (context, index) {
          final service = mentalWellBeingServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
