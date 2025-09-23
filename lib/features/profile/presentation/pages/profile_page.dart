import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/services/app_preferences.dart';
import 'package:vaccine_home/features/auth/presentation/pages/login_page.dart';
import 'package:vaccine_home/features/navigation/cubits/navigation_cubit.dart';
import 'package:vaccine_home/features/profile/data/models/profile_menu_item.dart';
import 'package:vaccine_home/features/profile/presentation/pages/change_password_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/feedbacks_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/privacy_policy_page.dart';
import 'package:vaccine_home/features/profile/presentation/pages/terms_and_conditions_page.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/profile_header.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/profile_section.dart';

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
    super.initState();
  }

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
      appBar: AppBar(title: const Text('Profile')),
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
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedCalendar02,
                  title: "Vaccine Schedule / Record",
                  onTap: () {},
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
                  title: "FAQ",
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// Settings Section
            ProfileSection(
              title: "Settings",
              items: [
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedNotification03,
                  title: "Notifications",
                  onTap: () {},
                ),
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
                  onTap: () async {
                    await AppPreferences.clearAll();
                    context.read<NavigationCubit>().resetIndex();
                    Navigator.pushReplacement(context, LoginPage.route());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
