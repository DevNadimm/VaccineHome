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
import 'package:vaccine_home/features/reminder/presentation/blocs/my_menstrual_cycle_alerts/my_menstrual_cycle_alerts_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/menstrual_cycle_alert_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/menstrual_cycle_alert_card.dart';

class MyMenstrualCycleAlertsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyMenstrualCycleAlertsPage());

  const MyMenstrualCycleAlertsPage({super.key});

  @override
  State<MyMenstrualCycleAlertsPage> createState() => _MyMenstrualCycleAlertsPageState();
}

class _MyMenstrualCycleAlertsPageState extends State<MyMenstrualCycleAlertsPage> {

  // _fetchMyMenstrualCycleAlerts() => context.read<MyMenstrualCycleAlertsBloc>().add(FetchMyMenstrualCycleAlertsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Menstrual Cycle Alerts'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocConsumer<MyMenstrualCycleAlertsBloc, MyMenstrualCycleAlertsState>(
        listener: (context, state) {
          if (state is DeleteMenstrualCycleAlertFailure) {
            AppNotifier.showToast(Messages.deleteMenstrualCycleAlertFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is MyMenstrualCycleAlertsLoaded && state.myMenstrualCycleAlerts.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.myMenstrualCycleAlerts.length,
              itemBuilder: (context, index) {
                final alert = state.myMenstrualCycleAlerts[index];
                return MenstrualCycleAlertCard(
                  menstrualCycle: alert,
                  onEdit: () {
                    Navigator.push(context, MenstrualCycleAlertFormPage.route(menstrualCycle: alert));
                  },
                  onDelete: () {
                    context.read<MyMenstrualCycleAlertsBloc>().add(DeleteMenstrualCycleAlertEvent(alert.id ?? 0));
                  },
                );
              },
            );
          } else if (state is MyMenstrualCycleAlertsLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MyMenstrualCycleAlertsFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Menstrual Cycle Alerts',
              message: 'We were unable to fetch your menstrual cycle alerts due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
                title: 'No Menstrual Cycle Alerts Available',
                message: "You don't have any menstrual cycle alerts added yet. Please check back later.",
            );
          }
        },
      ),
    );
  }
}