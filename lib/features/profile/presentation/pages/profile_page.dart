import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/features/profile/data/models/profile_menu_item.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/profile_header.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/profile_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ProfileHeader(),
            const SizedBox(height: 32),

            /// Account Section
            ProfileSection(
              title: "Account",
              items: [
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedEdit03,
                  title: "Edit Profile",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedLockPassword,
                  title: "Change Password",
                  onTap: () {},
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
                  title: "Vaccine Request History",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedCalendar02,
                  title: "Vaccine Schedule",
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
                  icon: HugeIcons.strokeRoundedDiscount01,
                  title: "Advertisement / Offers",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedComment01,
                  title: "Feedback",
                  onTap: () {},
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
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedFile01,
                  title: "Terms & Conditions",
                  onTap: () {},
                ),
                ProfileMenuItem(
                  icon: HugeIcons.strokeRoundedLogout03,
                  title: "Logout",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
