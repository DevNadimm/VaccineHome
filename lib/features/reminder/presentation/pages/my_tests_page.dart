import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/reminder/presentation/blocs/my_tests/my_tests_bloc.dart';

class MyTestsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const MyTestsPage());

  const MyTestsPage({super.key});

  @override
  State<MyTestsPage> createState() => _MyTestsPageState();
}

class _MyTestsPageState extends State<MyTestsPage> {
  @override
  void initState() {
    _fetchMyTests();
    super.initState();
  }

  _fetchMyTests() => context.read<MyTestsBloc>().add(FetchMyTestsEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tests'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            size: 32,
            color: AppColors.primaryFontColor,
          ),
        ),
      ),
        body: BlocBuilder<MyTestsBloc, MyTestsState>(
          builder: (context, state) {
            if (state is MyTestsLoaded && state.myTests.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: state.myTests.length,
                itemBuilder: (context, index) {
                  final test = state.myTests[index];
                  return Text(test.testName ?? '');
                },
              );
            } else if (state is MyTestsLoading) {
              return const Loader(color: AppColors.black);
            } else if (state is MyTestsFailure) {
              return const ErrorStateWidget(
                title: 'Failed to Load Tests',
                message: 'We were unable to fetch your tests due to a network issue or server error.',
              );
            } else {
              return const EmptyStateWidget(
                title: 'No Tests Available',
                message: 'You don’t have any tests scheduled yet. Please check back later.',
              );
            }
          },
        ),
    );
  }
}
