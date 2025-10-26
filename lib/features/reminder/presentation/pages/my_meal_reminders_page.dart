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
import 'package:vaccine_home/features/reminder/presentation/blocs/my_meal_reminders/my_meal_reminders_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/meal_reminder_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/meal_reminder_card.dart';

class MyMealRemindersPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyMealRemindersPage());

  const MyMealRemindersPage({super.key});

  @override
  State<MyMealRemindersPage> createState() => _MyMealRemindersPageState();
}

class _MyMealRemindersPageState extends State<MyMealRemindersPage> {

  // _fetchMyMealReminders() => context.read<MyMealRemindersBloc>().add(FetchMyMealRemindersEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Meal Alerts'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocConsumer<MyMealRemindersBloc, MyMealRemindersState>(
        listener: (context, state) {
          if (state is DeleteMealReminderFailure) {
            AppNotifier.showToast(Messages.deleteMealReminderFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is MyMealRemindersLoaded && state.myMealReminders.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.myMealReminders.length,
              itemBuilder: (context, index) {
                final reminder = state.myMealReminders[index];
                return MealReminderCard(
                  meal: reminder,
                  onEdit: () {
                    Navigator.push(context, MealReminderFormPage.route(meal: reminder));
                  },
                  onDelete: () {
                    context.read<MyMealRemindersBloc>().add(DeleteMealReminderEvent(reminder.id ?? 0));
                  },
                );
              },
            );
          } else if (state is MyMealRemindersLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MyMealRemindersFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Meal Alerts',
              message: 'We were unable to fetch your meal alerts due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Meal Alerts Available',
              message: 'You don’t have any meal alerts added yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
