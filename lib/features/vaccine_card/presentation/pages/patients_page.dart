import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/blocs/patients/patients_bloc.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/widgets/patient_card.dart';

class PatientsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PatientsPage());

  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  @override
  void initState() {
    _fetchPatients();
    super.initState();
  }

  void _fetchPatients() => context.read<PatientsBloc>().add(FetchPatientsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
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
                return PatientCard(
                  patient: patient,
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
