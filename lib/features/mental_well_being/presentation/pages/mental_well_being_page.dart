import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/pages/video_player_page.dart';

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VideoPlayerPage(
                videoUrl: 'https://www.youtube.com/watch?v=h0mKvhxky0Q&list=RDh0mKvhxky0Q&start_radio=1',
                videoTitle: 'Chaudhary Amit Trivedi feat Mame Khan, Coke Studio @ MTV Season 2',
                publishedDate: 'Oct 25, 2009',
              ),
            ),
          );
        },
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
