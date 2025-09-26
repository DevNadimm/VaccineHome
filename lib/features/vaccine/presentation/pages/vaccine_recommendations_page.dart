import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_recommentdation/vaccine_recommendation_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/recommendation_card.dart';

class VaccineRecommendationsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineRecommendationsPage());

  const VaccineRecommendationsPage({super.key});

  @override
  State<VaccineRecommendationsPage> createState() => _VaccineRecommendationsPageState();
}

class _VaccineRecommendationsPageState extends State<VaccineRecommendationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<VaccineRecommendationBloc, VaccineRecommendationState>(
        builder: (context, state) {
          if (state is VaccineRecommendationLoaded && (state.recommendations.isNotEmpty)) {
            final vaccines = state.recommendations;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: vaccines.length,
              itemBuilder: (context, index) {
                final vaccine = vaccines[index];
                return RecommendationCard(recommendation: vaccine);
              },
            );
          } else if (state is VaccineRecommendationLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is VaccineRecommendationFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Recommendations',
              message: 'We were unable to fetch the vaccine recommendations due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Recommendations Available',
              message: 'Currently, there are no vaccine recommendations listed. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
