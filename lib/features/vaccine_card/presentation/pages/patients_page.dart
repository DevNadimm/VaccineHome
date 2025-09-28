import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/patients/patients_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/pages/immunization_records.dart';

class PatientsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PatientsPage());

  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {

  // _fetchPatients() => context.read<PatientsBloc>().add(FetchPatientsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Card List'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<PatientsBloc, PatientsState>(
        builder: (context, state) {
          if (state is PatientsLoaded && state.patients.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.patients.length,
              itemBuilder: (context, index) {
                final patient = state.patients[index];
                return SubModuleCard(
                  subModule: SubModule(
                    icon: HugeIcons.strokeRoundedUser,
                    title: "${patient.firstNameEnglish} ${patient.lastNameEnglish ?? ''}" ,
                    subtitle: 'Tap here to view the card',
                    onTap: () {
                      Navigator.push(context, ImmunizationRecordsPage.route(patient: patient));
                    },
                  ),
                );
              },
            );
          } else if (state is PatientsLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is PatientsFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Patients',
              message: 'We were unable to fetch your patients due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Patients Available',
              message: 'You don’t have any patients added yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
