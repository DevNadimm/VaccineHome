import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/blocs/mental_well_being/mental_well_being_bloc.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/widgets/wellness_visual_card.dart';

class WellnessVisualsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const WellnessVisualsPage());

  const WellnessVisualsPage({super.key});

  @override
  State<WellnessVisualsPage> createState() => _WellnessVisualsPageState();
}

class _WellnessVisualsPageState extends State<WellnessVisualsPage> {
  @override
  void initState() {
    _fetchVisuals();
    super.initState();
  }

  _fetchVisuals() => context.read<MentalWellBeingBloc>().add(FetchMentalWellBeingEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Visuals'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<MentalWellBeingBloc, MentalWellBeingState>(
        builder: (context, state) {
          if (state is MentalWellBeingLoaded && (state.items.isNotEmpty)) {
            final visuals = state.items.where((i) => i.type == 'video').toList();
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: visuals.length,
              itemBuilder: (context, index) {
                final visual = visuals[index];
                return WellnessVisualCard(visual: visual);
              },
            );
          } else if (state is MentalWellBeingLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MentalWellBeingFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Wellness Visuals',
              message: 'We were unable to fetch your wellness visuals due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Wellness Visuals Available',
              message: 'No wellness visuals are available at the moment. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
