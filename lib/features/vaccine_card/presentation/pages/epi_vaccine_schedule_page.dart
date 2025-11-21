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

class EPIVaccineSchedulePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const EPIVaccineSchedulePage());

  const EPIVaccineSchedulePage({super.key});

  @override
  State<EPIVaccineSchedulePage> createState() => _EPIVaccineSchedulePageState();
}

class _EPIVaccineSchedulePageState extends State<EPIVaccineSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EPI Vaccine Schedule'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<VaccineScheduleBloc, VaccineScheduleState>(
        builder: (context, state) {
          if (state is VaccineScheduleLoaded && state.schedules.isNotEmpty) {
            // Find the EPI vaccine schedule
            final epiSchedule = state.schedules.firstWhere((schedule) => schedule.type == 'EPI Vaccine Schedule',
              orElse: () => VaccineScheduleData(type: null, schedules: []),
            );

            // Check if EPI schedule exists and has schedules
            if (epiSchedule.schedules == null || epiSchedule.schedules!.isEmpty) {
              return const EmptyStateWidget(
                title: 'No EPI Vaccines Available',
                message: 'There are no EPI vaccines in the schedule at the moment.',
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: epiSchedule.schedules!.length,
              itemBuilder: (context, index) {
                final schedule = epiSchedule.schedules![index];
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
