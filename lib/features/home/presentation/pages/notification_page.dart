import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/home/data/models/notification.dart';
import 'package:vaccine_home/features/home/presentation/widgets/empty_notification_widget.dart';
import 'package:vaccine_home/features/home/presentation/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const NotificationPage());

  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      // NotificationModel(
      //   title: "Vaccine Reminder",
      //   message: "Your next vaccine is scheduled for tomorrow at 10:00 AM.",
      //   createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      //   isRead: false,
      // ),
      // NotificationModel(
      //   title: "Health Checkup",
      //   message: "Your annual health checkup is due next week.",
      //   createdAt: DateTime.now().subtract(const Duration(days: 1)),
      //   isRead: true,
      // ),
      // NotificationModel(
      //   title: "Diet Reminder",
      //   message: "Don't forget to take your evening meal on time.",
      //   createdAt: DateTime.now().subtract(const Duration(days: 10)),
      //   isRead: true,
      // ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(notification: notification);
              },
            )
          : const EmptyNotificationWidget(),
    );
  }
}
