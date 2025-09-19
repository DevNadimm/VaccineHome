import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/home/presentation/blocs/notification/notification_bloc.dart';
import 'package:vaccine_home/features/home/presentation/widgets/empty_notification_widget.dart';
import 'package:vaccine_home/features/home/presentation/widgets/notification_card.dart';

class NotificationPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const NotificationPage());

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    _fetchNotifications();
    super.initState();
  }

  _fetchNotifications() => context.read<NotificationBloc>().add(FetchNotificationsEvent());

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoaded && (state.notificationModel.notifications?.isNotEmpty ?? false)) {
            final notifications = state.notificationModel.notifications!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(notification: notification);
              },
            );
          } else if (state is NotificationLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is NotificationFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Notifications',
              message: 'We were unable to fetch your notifications due to a network issue or server error.'
            );
          } else {
            return const EmptyNotificationWidget();
          }
        },
      ),
    );
  }
}
