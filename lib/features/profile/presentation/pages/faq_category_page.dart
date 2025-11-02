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
import 'package:vaccine_home/features/profile/presentation/blocs/faq/faq_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/pages/faq_page.dart';

class FAQCategoryPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const FAQCategoryPage());
  const FAQCategoryPage({super.key});

  @override
  State<FAQCategoryPage> createState() => _FAQCategoryPageState();
}

class _FAQCategoryPageState extends State<FAQCategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ Categories'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<FAQBloc, FAQState>(
        builder: (context, state) {
          if (state is FAQLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is FAQFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Categories',
              message: 'We were unable to fetch FAQ categories due to a network issue or server error.',
            );
          } else if (state is FAQLoaded && state.categories.isNotEmpty) {
            final categories = state.categories;

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return SubModuleCard(
                  subModule: SubModule(
                    icon: HugeIcons.strokeRoundedHelpCircle,
                    title: category.name ?? 'Untitled Category',
                    subtitle: 'Tap here to view the faqs',
                    onTap: () => Navigator.push(context, FAQPage.route(faqs: category.faqs ?? [])),
                  ),
                );
              },
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Categories Available',
              message: 'No FAQ categories are available at the moment. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
