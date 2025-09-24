import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_water_reminders/my_water_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/water_reminder_form_page_page.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/water_reminder_card.dart';

class MyWaterRemindersPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyWaterRemindersPage());

  const MyWaterRemindersPage({super.key});

  @override
  State<MyWaterRemindersPage> createState() => _MyWaterRemindersPageState();
}

class _MyWaterRemindersPageState extends State<MyWaterRemindersPage> {
  @override
  void initState() {
    _fetchMyWaterReminders();
    super.initState();
  }

  _fetchMyWaterReminders() => context.read<MyWaterRemindersBloc>().add(FetchMyWaterRemindersEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Water Reminders'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocConsumer<MyWaterRemindersBloc, MyWaterRemindersState>(
        listener: (context, state) {
          if (state is DeleteWaterReminderFailure) {
            AppNotifier.showToast(Messages.deleteWaterReminderFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is MyWaterRemindersLoaded && state.myWaterReminders.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.myWaterReminders.length,
              itemBuilder: (context, index) {
                final reminder = state.myWaterReminders[index];
                return WaterReminderCard(
                  water: reminder,
                  onEdit: () {
                    Navigator.push(context, WaterReminderFormPage.route(water: reminder));
                  },
                  onDelete: () {
                    context.read<MyWaterRemindersBloc>().add(DeleteWaterReminderEvent(reminder.id ?? 0));
                  },
                );
              },
            );
          } else if (state is MyWaterRemindersLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MyWaterRemindersFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Water Reminders',
              message: 'We were unable to fetch your water reminders due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Water Reminders Available',
              message: 'You don’t have any water reminders added yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
