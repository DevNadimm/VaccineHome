import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class NotificationActionBottomSheetContent extends StatelessWidget {
  final VoidCallback onMarkAllNotificationsAsRead;
  final VoidCallback onDeleteAllNotifications;

  const NotificationActionBottomSheetContent({
    super.key,
    required this.onMarkAllNotificationsAsRead,
    required this.onDeleteAllNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Actions',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onMarkAllNotificationsAsRead,
              child: const Text('Mark all as read'),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onDeleteAllNotifications,
              child: const Text('Delete all notifications'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
