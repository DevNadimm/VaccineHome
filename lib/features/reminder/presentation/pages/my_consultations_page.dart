import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_consultations/my_consultations_bloc.dart';

class MyConsultationsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyConsultationsPage());

  const MyConsultationsPage({super.key});

  @override
  State<MyConsultationsPage> createState() => _MyConsultationsPageState();
}

class _MyConsultationsPageState extends State<MyConsultationsPage> {
  @override
  void initState() {
    _fetchMyConsultations();
    super.initState();
  }

  _fetchMyConsultations() => context.read<MyConsultationsBloc>().add(FetchMyConsultationsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Consultations'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
      body: BlocBuilder<MyConsultationsBloc, MyConsultationsState>(
        builder: (context, state) {
          if (state is MyConsultationsLoaded && state.myConsultations.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.myConsultations.length,
              itemBuilder: (context, index) {
                final consultation = state.myConsultations[index];
                return Text(consultation.doctorName ?? '');
              },
            );
          } else if (state is MyConsultationsLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MyConsultationsFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Consultations',
              message: 'We were unable to fetch your consultations due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Consultations Available',
              message: 'You don’t have any consultations scheduled yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
