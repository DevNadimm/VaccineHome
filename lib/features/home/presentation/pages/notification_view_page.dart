import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/features/home/data/models/notification_model.dart';
import 'package:vaccine_home/features/home/presentation/blocs/notification/notification_bloc.dart';

class NotificationViewPage extends StatefulWidget {
  static Route route(NotificationData notification) => MaterialPageRoute(builder: (_) => NotificationViewPage(notification: notification));

  final NotificationData notification;

  const NotificationViewPage({super.key, required this.notification});

  @override
  State<NotificationViewPage> createState() => _NotificationViewPageState();
}

class _NotificationViewPageState extends State<NotificationViewPage> {
  @override
  void initState() {
    _readNotification();
    super.initState();
  }

  _readNotification() => context.read<NotificationBloc>().add(ReadNotificationsEvent(widget.notification.id ?? ''));

  @override
  Widget build(BuildContext context) {
    final notification = widget.notification;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
        title: const Text("Notification"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                if (notification.data?.title != null)
                  Text(
                    notification.data!.title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryFontColor,
                    ),
                  ),

                const SizedBox(height: 12),

                // Message
                if (notification.data?.message != null)
                  Text(
                    notification.data!.message!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.secondaryFontColor,
                      height: 1.5,
                    ),
                  ),

                const SizedBox(height: 20),

                // Time ago
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    notification.timeAgo,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
