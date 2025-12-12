import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/features/auth/presentation/pages/welcome_page.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/profile/data/models/profile_menu_item.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/faq/faq_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/vaccine_order_history/vaccine_order_history_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/pages/change_password_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/faq_category_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/feedbacks_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/privacy_policy_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/terms_and_conditions_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/vaccine_order_history_page.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/profile_header.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/profile_section.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/patients/patients_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/pages/patients_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;
  String? userEmail;
  String? userPhone;
  String? userAvatar;

  @override
  void initState() {
    getPreference();
    _fetchOrderHistory();
    _fetchFeedbacks();
    _fetchFAQs();
    _fetchPatients();
    super.initState();
  }

  void _fetchOrderHistory() => context.read<VaccineOrderHistoryBloc>().add(FetchVaccineOrderHistoryEvent());
  void _fetchFeedbacks() => context.read<FeedbackBloc>().add(FetchFeedbacksEvent());
  void _fetchFAQs() => context.read<FAQBloc>().add(FetchFAQEvent());
  void _fetchPatients() => context.read<PatientsBloc>().add(FetchPatientsEvent());

  Future<void> getPreference() async {
    final name = await AppPreferences.getUserName();
    final email = await AppPreferences.getUserEmail();
    final phone = await AppPreferences.getUserPhone();
    final avatar = await AppPreferences.getUserAvatar();

    setState(() {
      userName = name;
      userEmail = email;
      userPhone = phone;
      userAvatar = avatar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeader(
              name: userName?.isNotEmpty == true ? userName! : 'No Name',
              email: userEmail?.isNotEmpty == true ? userEmail! : 'No Email',
              phone: userPhone?.isNotEmpty == true ? userPhone! : 'No Phone',
              avatar: userAvatar ?? '',
            ),
            const SizedBox(height: 32),

            /// Account Section
            ProfileSection(
              title: "Account",
              items: [
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedEdit03,
                  title: "Edit Profile",
                  onTap: () {
                    Navigator.push(context, EditProfilePage.route());
                  },
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedLockPassword,
                  title: "Change Password",
                  onTap: () {
                    Navigator.push(context, ChangePasswordPage.route());
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Vaccination Section
            ProfileSection(
              title: "Vaccination",
              items: [
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedHealth,
                  title: "Vaccine Order History",
                  onTap: () {
                    Navigator.push(context, VaccineOrderHistoryPage.route());
                  },
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedCalendar02,
                  title: "Vaccine Schedule / Record",
                  onTap: () {
                    Navigator.push(context, PatientsPage.route());
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Engagement Section
            ProfileSection(
              title: "Engagement",
              items: [
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedComment01,
                  title: "Feedback",
                  onTap: () {
                    Navigator.push(context, FeedbacksPage.route());
                  },
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedHelpCircle,
                  title: "FAQs",
                  onTap: () {
                    Navigator.push(context, FAQCategoryPage.route());
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Settings Sectionfvm flutter run
            ProfileSection(
              title: "Settings",
              items: [
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedSecurity,
                  title: "Privacy Policy",
                  onTap: () {
                    Navigator.push(context, PrivacyPolicyPage.route());
                  },
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedFile01,
                  title: "Terms & Conditions",
                  onTap: () {
                    Navigator.push(context, TermsAndConditionsPage.route());
                  },
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedLogout03,
                  title: "Logout",
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          elevation: 12,
          backgroundColor: AppColors.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    HugeIcons.strokeRoundedLogout03,
                    size: 60,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Confirm Logout',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Are you sure you want to log out of your account?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: AppColors.secondaryFontColor,
                      height: 1.3,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.inputBorderColor),
                          foregroundColor: AppColors.secondaryFontColor,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await AppPreferences.clearAll();
                          context.read<NavigationCubit>().resetIndex();
                          Navigator.pushReplacement(context, WelcomePage.route());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
