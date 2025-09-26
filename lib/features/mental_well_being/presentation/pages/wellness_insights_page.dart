import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/blocs/mental_well_being/mental_well_being_bloc.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/widgets/wellness_insight_card.dart';

class WellnessInsightsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const WellnessInsightsPage());

  const WellnessInsightsPage({super.key});

  @override
  State<WellnessInsightsPage> createState() => _WellnessInsightsPageState();
}

class _WellnessInsightsPageState extends State<WellnessInsightsPage> {

  // _fetchInsights() => context.read<MentalWellBeingBloc>().add(FetchMentalWellBeingEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Insights'),
        leading: const AppBarBackBtn()
      ),
      body: BlocBuilder<MentalWellBeingBloc, MentalWellBeingState>(
        builder: (context, state) {
          if (state is MentalWellBeingLoaded && (state.items.isNotEmpty)) {
            final articles = state.items.where((i) => i.type == 'article').toList();
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return WellnessInsightCard(insight: article);
              },
            );
          } else if (state is MentalWellBeingLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is MentalWellBeingFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Wellness Insights',
              message: 'We were unable to fetch your wellness insights due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Wellness Insights Available',
              message: 'No wellness insights are available at the moment. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
