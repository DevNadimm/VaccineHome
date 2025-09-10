import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';

class MentalWellBeingPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MentalWellBeingPage());

  const MentalWellBeingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mentalWellBeingServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedLibrary,
        title: "Health Tips",
        subtitle: "Daily tips to keep your health in check.",
        onTap: () {},
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedSmile,
        title: "Stress Management",
        subtitle: "Relax and manage stress effectively.",
        onTap: () {},
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedUser,
        title: "Online Consultancy",
        subtitle: "Talk to a consultant for mental well-being.",
        onTap: () {},
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mental Well Being'),
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
        itemCount: mentalWellBeingServices.length,
        itemBuilder: (context, index) {
          final service = mentalWellBeingServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
