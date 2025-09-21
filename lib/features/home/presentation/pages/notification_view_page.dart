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
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
