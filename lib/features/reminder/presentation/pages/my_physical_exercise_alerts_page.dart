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
import 'package:vaccine_home/features/reminder/presentation/blocs/my_physical_exercise_alerts/my_physical_exercise_alerts_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/physical_exercise_alert_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/physical_exercise_alert_card.dart';

class MyPhysicalExerciseAlertsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyPhysicalExerciseAlertsPage());

  const MyPhysicalExerciseAlertsPage({super.key});

  @override
  State<MyPhysicalExerciseAlertsPage> createState() => _MyPhysicalExerciseAlertsPageState();
}

class _MyPhysicalExerciseAlertsPageState extends State<MyPhysicalExerciseAlertsPage> {

  // _fetchMyPhysicalExerciseAlerts() => context.read<MyPhysicalExerciseAlertsBloc>().add(FetchMyPhysicalExerciseAlertsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Physical Exercise Alerts'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocConsumer<MyPhysicalExerciseAlertsBloc, MyPhysicalExerciseAlertsState>(
        listener: (context, state) {
          if (state is DeletePhysicalExerciseAlertFailure) {
            AppNotifier.showToast(Messages.deletePhysicalExerciseAlertFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is MyPhysicalExerciseAlertsLoaded && state.myPhysicalExerciseAlerts.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.myPhysicalExerciseAlerts.length,
              itemBuilder: (context, index) {
                final alert = state.myPhysicalExerciseAlerts[index];
                return PhysicalExerciseAlertCard(
                  exercise: alert,
                  onEdit: () {
                    Navigator.push(context, PhysicalExerciseAlertFormPage.route(exercise: alert));
                  },
                  onDelete: () {
                    context.read<MyPhysicalExerciseAlertsBloc>().add(DeletePhysicalExerciseAlertEvent(alert.id ?? 0));
                  },
                );
              },
            );
          } else if (state is MyPhysicalExerciseAlertsLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MyPhysicalExerciseAlertsFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Physical Exercise Alerts',
              message: 'We were unable to fetch your physical exercise alerts due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Physical Exercise Alerts Available',
              message: "You don't have any physical exercise alerts added yet. Please check back later.",
            );
          }
        },
      ),
    );
  }
}