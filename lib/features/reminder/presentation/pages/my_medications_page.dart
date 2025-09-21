import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_medications/my_medications_bloc.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/medication_form_page.dart';
import 'package:vaccine_home/features/reminder/presentation/widgets/medication_card.dart';

class MyMedicationsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyMedicationsPage());

  const MyMedicationsPage({super.key});

  @override
  State<MyMedicationsPage> createState() => _MyMedicationsPageState();
}

class _MyMedicationsPageState extends State<MyMedicationsPage> {
  @override
  void initState() {
    _fetchMyMedications();
    super.initState();
  }

  _fetchMyMedications() => context.read<MyMedicationsBloc>().add(FetchMyMedicationsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Medications'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: BlocConsumer<MyMedicationsBloc, MyMedicationsState>(
        listener: (context, state) {
          if (state is DeleteMedicationFailure) {
            AppNotifier.showToast(Messages.deleteMedicationFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is MyMedicationsLoaded && state.myMedications.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.myMedications.length,
              itemBuilder: (context, index) {
                final medication = state.myMedications[index];
                return MedicationCard(
                  medication: medication,
                  onEdit: () {
                    Navigator.push(context, MedicationFormPage.route(medication: medication));
                  },
                  onDelete: () {
                    context.read<MyMedicationsBloc>().add(DeleteMedicationEvent(medication.id ?? 0));
                  },
                );
              },
            );
          } else if (state is MyMedicationsLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MyMedicationsFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Medications',
              message: 'We were unable to fetch your medications due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Medications Available',
              message: 'You don’t have any medications added yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
