import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine_card/data/models/vaccine_schedule_model.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/vaccine_schedule/vaccine_schedule_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/widgets/schedule_card.dart';

class PrivateVaccineSchedulePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PrivateVaccineSchedulePage());

  const PrivateVaccineSchedulePage({super.key});

  @override
  State<PrivateVaccineSchedulePage> createState() => _PrivateVaccineSchedulePageState();
}

class _PrivateVaccineSchedulePageState extends State<PrivateVaccineSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Private Vaccine Schedule'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<VaccineScheduleBloc, VaccineScheduleState>(
        builder: (context, state) {
          if (state is VaccineScheduleLoaded && state.schedules.isNotEmpty) {
            // Find the private vaccine schedule
            final privateSchedule = state.schedules.firstWhere((schedule) => schedule.type == 'Private Vaccine Schedule',
              orElse: () => VaccineScheduleData(type: null, schedules: []),
            );

            // Check if private schedule exists and has schedules
            if (privateSchedule.schedules == null || privateSchedule.schedules!.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Private Vaccines Available',
                message: 'There are no private vaccines in the schedule at the moment.',
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: privateSchedule.schedules!.length,
              itemBuilder: (context, index) {
                final schedule = privateSchedule.schedules![index];
                return VaccineScheduleCard(
                  schedule: schedule,
                );
              },
            );
          } else if (state is VaccineScheduleLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is VaccineScheduleFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Vaccine Schedule',
              message: 'We were unable to fetch the vaccine schedule due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Vaccine Schedule Available',
              message: 'There are no vaccine schedules available at the moment. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
