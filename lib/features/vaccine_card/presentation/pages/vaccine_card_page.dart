import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';

class VaccineCardPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineCardPage());

  const VaccineCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vaccineCardServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedClipboard,
        title: "Vaccine Card Schedule",
        subtitle: "Track your upcoming vaccination dates.",
        onTap: () {},
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedSecurity,
        title: "Vaccine Card Verification",
        subtitle: "Verify your digital vaccine card instantly.",
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Card'),
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
        itemCount: vaccineCardServices.length,
        itemBuilder: (context, index) {
          final service = vaccineCardServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
