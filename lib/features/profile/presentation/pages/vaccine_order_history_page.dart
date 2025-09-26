import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/constants/messages.dart';
import 'package:vaccine_home/core/utils/enums/message_type.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/app_notifier.dart';
import 'package:vaccine_home/core/utils/widgets/empty_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/error_state_widget.dart';
import 'package:vaccine_home/core/utils/widgets/loader.dart';
import 'package:vaccine_home/features/profile/presentation/blocs/vaccine_order_history/vaccine_order_history_bloc.dart';
import 'package:vaccine_home/features/profile/presentation/widgets/vaccine_order_card.dart';

class VaccineOrderHistoryPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccineOrderHistoryPage());

  const VaccineOrderHistoryPage({super.key});

  @override
  State<VaccineOrderHistoryPage> createState() => _VaccineOrderHistoryPageState();
}

class _VaccineOrderHistoryPageState extends State<VaccineOrderHistoryPage> {

  // _fetchOrderHistory() => context.read<VaccineOrderHistoryBloc>().add(FetchVaccineOrderHistoryEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine Order History'),
        leading: const AppBarBackBtn(),
      ),
      body: BlocConsumer<VaccineOrderHistoryBloc, VaccineOrderHistoryState>(
        listener: (context, state) {
          if (state is VaccineOrderHistoryFailure) {
            AppNotifier.showToast(Messages.orderFetchFailed, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is VaccineOrderHistoryLoaded && state.vaccineOrderHistory.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: state.vaccineOrderHistory.length,
              itemBuilder: (context, index) {
                final order = state.vaccineOrderHistory[index];
                return VaccineOrderCard(
                  order: order,
                );
              },
            );
          } else if (state is VaccineOrderHistoryLoading) {
            return const Loader(color: AppColors.black);
          } else if (state is VaccineOrderHistoryFailure) {
            return const ErrorStateWidget(
              title: 'Failed to Load Orders',
              message: 'We were unable to fetch your vaccine orders due to a network issue or server error.',
            );
          } else {
            return const EmptyStateWidget(
              title: 'No Orders Available',
              message: 'You haven’t made any vaccine orders yet. Please check back later.',
            );
          }
        },
      ),
    );
  }
}
