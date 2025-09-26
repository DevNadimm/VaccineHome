import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_product/vaccine_product_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/widgets/vaccine_product_card.dart';

class VaccineListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineListPage());

  const VaccineListPage({super.key});

  @override
  State<VaccineListPage> createState() => _VaccineListPageState();
}

class _VaccineListPageState extends State<VaccineListPage> {

  // _fetchVaccines() => context.read<VaccineProductBloc>().add(FetchVaccineProducts());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine List'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocBuilder<VaccineProductBloc, VaccineProductState>(
        builder: (context, state) {
          if (state is VaccineProductSuccess && (state.products.isNotEmpty)) {
            final vaccines = state.products;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: vaccines.length,
              itemBuilder: (context, index) {
                final vaccine = vaccines[index];
                return VaccineProductCard(vaccineProduct: vaccine);
              },
            );
          } else if (state is VaccineProductLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is VaccineProductFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Vaccine List',
              message: 'We were unable to fetch the vaccine list due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Vaccines Available',
              message: 'Currently, there are no vaccines listed. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
