import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/helper_functions/show_custom_bottom_sheet.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/custom_text_field.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/rating_cubit.dart';

class SubmitFeedbackPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const SubmitFeedbackPage());

  const SubmitFeedbackPage({super.key});

  @override
  State<SubmitFeedbackPage> createState() => _SubmitFeedbackPageState();
}

class _SubmitFeedbackPageState extends State<SubmitFeedbackPage> {
  final GlobalKey<FormState> globalKey = GlobalKey();
  final TextEditingController feedbackMessage = TextEditingController();
  final TextEditingController experience = TextEditingController();
  final TextEditingController feedbackType = TextEditingController();
  final TextEditingController improvementArea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        if (state is SubmitFeedbackFailure) {
          AppNotifier.showToast(
            Messages.feedbackSubmitFailed,
            type: MessageType.error,
          );
        }
        if (state is SubmitFeedbackSuccess) {
          AppNotifier.showToast(
            Messages.feedbackSubmitSuccess,
            type: MessageType.success,
          );
          clearFields();
          context.read<RatingCubit>().reset();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
            if (state is SubmitFeedbackLoading)
              Container(
                color: AppColors.black.withOpacity(0.6),
                child: const Loader(),
              ),
          ],
        );
      },
    );
  }

  Widget content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Feedback'),
        leading: AppBarBackBtn(
          onBack: (){
            context.read<RatingCubit>().reset();
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRatingSection(context),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Feedback Message',
                controller: feedbackMessage,
                isRequired: true,
                hintText: 'Enter your feedback',
                validationLabel: 'Feedback',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Experience',
                hintText: 'Select experience',
                controller: experience,
                isRequired: true,
                readOnly: true,
                onTap: () {
                  showCustomBottomSheet(
                    context: context,
                    items: ['Excellent', 'Good', 'Average', 'Poor'],
                    controller: experience,
                    title: 'Select Experience',
                  );
                },
                validationLabel: 'Experience',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Feedback Type',
                hintText: 'Select feedback type',
                controller: feedbackType,
                isRequired: true,
                readOnly: true,
                onTap: () {
                  showCustomBottomSheet(
                    context: context,
                    items: ['Complaint', 'Suggestion', 'Compliment'],
                    controller: feedbackType,
                    title: 'Select Feedback Type',
                  );
                },
                validationLabel: 'Feedback type',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Improvement Area',
                hintText: 'Select improvement area',
                controller: improvementArea,
                isRequired: true,
                readOnly: true,
                onTap: () {
                  showCustomBottomSheet(
                    context: context,
                    items: ['Speed', 'Quality', 'Price'],
                    controller: improvementArea,
                    title: 'Select Improvement Area',
                  );
                },
                validationLabel: 'Improvement area',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveFeedback,
                  child: const Text('Submit Feedback'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveFeedback() {
    if (globalKey.currentState?.validate() ?? false) {
      final rating = context.read<RatingCubit>().state;

      context.read<FeedbackBloc>().add(
        SubmitFeedbackEvent(
          rating: rating,
          feedbackMessage: feedbackMessage.text,
          experience: experience.text,
          feedbackType: feedbackType.text,
          improvementArea: improvementArea.text,
        ),
      );
    }
  }

  void clearFields() {
    feedbackMessage.clear();
    experience.clear();
    feedbackType.clear();
    improvementArea.clear();
  }

  @override
  void dispose() {
    feedbackMessage.dispose();
    experience.dispose();
    feedbackType.dispose();
    improvementArea.dispose();
    super.dispose();
  }

  Widget _buildRatingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How was your experience?',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryFontColor,
            ),
          ),
        ),
        const SizedBox(height: 4),
        BlocBuilder<RatingCubit, int>(
          builder: (context, rating) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    context.read<RatingCubit>().setRating(index + 1);
                  },
                  icon: Icon(
                    index < rating ? CupertinoIcons.star_fill : CupertinoIcons.star,
                    color: Colors.amber,
                  ),
                );
              }),
            );
          },
        )
      ],
    );
  }
}
