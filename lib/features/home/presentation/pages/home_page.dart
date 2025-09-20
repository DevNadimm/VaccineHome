import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/utils/helper_functions/greeting_helper.dart';
import 'package:vaccine_home/core/utils/widgets/advertisement_carousel_slider.dart';
import 'package:vaccine_home/features/home/data/models/service.dart';
import 'package:vaccine_home/features/home/data/repositories/service_repository.dart';
import 'package:vaccine_home/features/home/presentation/blocs/advertisement/advertisement_bloc.dart';
import 'package:vaccine_home/features/home/presentation/pages/notification_page.dart';
import 'package:vaccine_home/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vaccine_home/features/home/presentation/widgets/service_card.dart';

class HomePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  String? userAvatar;

  @override
  void initState() {
    super.initState();
    _getPreferences();
  }

  Future<void> _getPreferences() async {
    final name = await AppPreferences.getUserName();
    final avatar = await AppPreferences.getUserAvatar();
    setState(() {
      userName = name ?? 'No Name';
      userAvatar = avatar ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        greetingText: getGreetingMessage(),
        userName: userName ?? 'No Name',
        userAvatar: userAvatar ?? '',
        onNotificationTap: () {
          Navigator.push(context, NotificationPage.route());
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AdvertisementBloc, AdvertisementState>(
                builder: (context, state) {
                  if (state is AdvertisementSuccess) {
                    return AdvertisementCarouselSlider(
                      imageUrls: state.model.advertisements?.map((e) => e.image ?? '').toList() ?? [],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          AssetPaths.banner,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 34),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Services',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
