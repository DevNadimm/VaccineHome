import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/pages/submit_feedback_page.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/feedback_card.dart';

class FeedbacksPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const FeedbacksPage());

  const FeedbacksPage({super.key});

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {

  // _fetchFeedbacks() => context.read<FeedbackBloc>().add(FetchFeedbacksEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedbacks'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<FeedbackBloc, FeedbackState>(
        builder: (context, state) {
          if (state is FeedbackLoaded && (state.feedbacks.isNotEmpty)) {
            final feedbacks = state.feedbacks;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: feedbacks.length,
              itemBuilder: (context, index) {
                final feedback = feedbacks[index];
                return FeedbackCard(feedback: feedback);
              },
            );
          } else if (state is FeedbackLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is FeedbackFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Feedback',
              message: 'We were unable to fetch your feedback due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Feedback Available',
              message: 'No feedback is available at the moment. Please check back later.',
            );
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, SubmitFeedbackPage.route());
              },
              child: const Text(
                "Submit Your Feedback",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
