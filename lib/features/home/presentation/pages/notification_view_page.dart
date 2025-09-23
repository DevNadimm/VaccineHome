import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
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
        leading: const AppBarBackBtn(),
        title: const Text('Notification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                notification.data!.title!,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
              Text(
                notification.timeAgo,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.secondaryFontColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 3,
                width: 75,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Text(
                      notification.data!.message!,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.secondaryFontColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
