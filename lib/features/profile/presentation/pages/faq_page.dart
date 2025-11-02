import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/profile/data/models/faq_model.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/faq/faq_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/faq_card.dart';

class FAQPage extends StatefulWidget {
  static Route route({required List<FAQ> faqs}) => MaterialPageRoute(builder: (_) => FAQPage(faqs: faqs));

  final List<FAQ> faqs;

  const FAQPage({super.key, required this.faqs});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<FAQBloc, FAQState>(
        builder: (context, state) {
          if (state is FAQLoaded && (state.categories.isNotEmpty)) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: widget.faqs.length,
              itemBuilder: (context, index) {
                final faq = widget.faqs[index];
                return FAQCard(faq: faq);
              },
            );
          } else if (state is FAQLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is FAQFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load FAQs',
              message: 'We were unable to fetch FAQs due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No FAQs Available',
              message: 'No FAQs are available at the moment. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
