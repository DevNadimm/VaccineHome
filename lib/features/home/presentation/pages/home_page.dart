import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/core/utils/helper_functions/greeting_helper.dart';
import 'package:vaccine_home/core/utils/widgets/advertisement_carousel_slider.dart';
import 'package:vaccine_home/features/home/data/models/popup_banner_model.dart';
import 'package:vaccine_home/features/home/data/models/service.dart';
import 'package:vaccine_home/features/home/data/repositories/service_repository.dart';
import 'package:vaccine_home/features/home/presentation/blocs/advertisement/advertisement_bloc.dart';
import 'package:vaccine_home/features/home/presentation/blocs/notification/notification_bloc.dart';
import 'package:vaccine_home/features/home/presentation/blocs/popup_banner/popup_banner_bloc.dart';
import 'package:vaccine_home/features/home/presentation/pages/notification_page.dart';
import 'package:vaccine_home/features/home/presentation/widgets/home_app_bar.dart';
import 'package:vaccine_home/features/home/presentation/widgets/popup_banner_dialog.dart';
import 'package:vaccine_home/features/home/presentation/widgets/service_card.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/blocs/mental_well_being/mental_well_being_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_product/vaccine_product_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_recommentdation/vaccine_recommendation_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/vaccine_schedule/vaccine_schedule_bloc.dart';

class HomePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userName;
  String? _userAvatar;

  @override
  void initState() {
    super.initState();
    _checkPopupBanner();
    _fetchNotifications();
    _fetchContents();
    _fetchVaccines();
    _fetchRecommendations();
    _fetchSchedules();
    _getPreferences();
  }

  Future<void> _getPreferences() async {
    final name = await AppPreferences.getUserName();
    final avatar = await AppPreferences.getUserAvatar();
    setState(() {
      _userName = name ?? 'No Name';
      _userAvatar = avatar ?? '';
    });
  }

  void _checkPopupBanner() => context.read<PopupBannerBloc>().add(CheckPopupBannerEvent());
  void _fetchNotifications() => context.read<NotificationBloc>().add(FetchNotificationsEvent());
  void _fetchContents() => context.read<MentalWellBeingBloc>().add(FetchMentalWellBeingEvent());
  void _fetchVaccines() => context.read<VaccineProductBloc>().add(FetchVaccineProducts());
  void _fetchRecommendations() => context.read<VaccineRecommendationBloc>().add(FetchVaccineRecommendationEvent());
  void _fetchSchedules() => context.read<VaccineScheduleBloc>().add(FetchVaccineSchedulesEvent());

  @override
  Widget build(BuildContext context) {
    return BlocListener<PopupBannerBloc, PopupBannerState>(
      listener: (context, state) {
        if (state is PopupBannerLoaded) {
          _showPopupBanner(context, state.banner);
        }
      },
      child: Scaffold(
        appBar: HomeAppBar(
          greetingText: getGreetingMessage(),
          userName: _userName ?? 'No Name',
          userAvatar: _userAvatar ?? '',
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
                      final imageUrls = state.model.advertisements?.where((e) => e.isActive == true).map((e) => e.image ?? '').where((url) => url.isNotEmpty).toList() ?? [];

                      if (imageUrls.isEmpty) {
                        return _buildDefaultBanner();
                      }

                      return AdvertisementCarouselSlider(imageUrls: imageUrls);
                    } else {
                      return _buildDefaultBanner();
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
      ),
    );
  }

  void _showPopupBanner(BuildContext context, PopupBannerData banner) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return PopupBannerDialog(banner: banner);
      },
    );
  }

  Widget _buildDefaultBanner() {
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
}
