import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
import 'package:vaccine_home/core/utils/helper_functions/greeting_helper.dart';
import 'package:vaccine_home/features/home/data/models/service.dart';
import 'package:vaccine_home/features/home/data/repositories/service_repository.dart';
import 'package:vaccine_home/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vaccine_home/features/home/presentation/widgets/service_card.dart';

class HomePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomePage());

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        greetingText: getGreetingMessage(),
        userName: 'Nadim Chowdhury',
        userAvatar: AssetPaths.nadimCorporate,
        onNotificationTap: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(AssetPaths.banner),
              ),
              const SizedBox(height: 34),
              Text(
                'Services',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: ServiceRepository.services(context).length,
                itemBuilder: (context, index) {
                  Service service = ServiceRepository.services(context)[index];
                  return ServiceCard(service: service);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
