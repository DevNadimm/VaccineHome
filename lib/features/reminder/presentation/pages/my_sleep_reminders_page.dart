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
import 'package:vaccine_home/features/reminder/presentation/blocs/my_sleep_reminders/my_sleep_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/sleep_reminder_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/sleep_reminder_card.dart';

class MySleepRemindersPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MySleepRemindersPage());

  const MySleepRemindersPage({super.key});

  @override
  State<MySleepRemindersPage> createState() => _MySleepRemindersPageState();
}

class _MySleepRemindersPageState extends State<MySleepRemindersPage> {

  // _fetchMySleepReminders() => context.read<MySleepRemindersBloc>().add(FetchMySleepRemindersEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Sleep Reminders'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocConsumer<MySleepRemindersBloc, MySleepRemindersState>(
        listener: (context, state) {
          if (state is DeleteSleepReminderFailure) {
            AppNotifier.showToast(Messages.deleteSleepReminderFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is MySleepRemindersLoaded && state.mySleepReminders.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.mySleepReminders.length,
              itemBuilder: (context, index) {
                final reminder = state.mySleepReminders[index];
                return SleepReminderCard(
                  sleep: reminder,
                  onEdit: () {
                    Navigator.push(context, SleepReminderFormPage.route(sleep: reminder));
                  },
                  onDelete: () {
                    context.read<MySleepRemindersBloc>().add(DeleteSleepReminderEvent(reminder.id ?? 0));
                  },
                );
              },
            );
          } else if (state is MySleepRemindersLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MySleepRemindersFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Sleep Reminders',
              message: 'We were unable to fetch your sleep reminders due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Sleep Reminders Available',
              message: 'You don’t have any sleep reminders added yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
