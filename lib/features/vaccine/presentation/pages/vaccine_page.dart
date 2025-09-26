import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/models/sub_module.dart';
import 'package:vaccine_home/core/utils/widgets/app_bar_back_btn.dart';
import 'package:vaccine_home/core/utils/widgets/sub_module_card.dart';
import 'package:vaccine_home/features/vaccine/presentation/blocs/vaccine_product/vaccine_product_bloc.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/online_vaccine_appoinment_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/vaccine_list_page.dart';

class VaccinePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const VaccinePage());

  const VaccinePage({super.key});

  @override
  State<VaccinePage> createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {

  @override
  void initState() {
    _fetchVaccines();
    super.initState();
  }

  _fetchVaccines() => context.read<VaccineProductBloc>().add(FetchVaccineProducts());

  @override
  Widget build(BuildContext context) {
    final vaccineServices = [
      SubModule(
        icon: HugeIcons.strokeRoundedVaccine,
        title: "Vaccine List & Order",
        subtitle: "Browse vaccine list, details, and order a vaccine.",
        onTap: () {
          Navigator.push(context, VaccineListPage.route());
        },
      ),
      SubModule(
        icon: HugeIcons.strokeRoundedCalendar02,
        title: "Online Vaccine Appointment",
        subtitle: "Book your vaccine appointments online.",
        onTap: () {
          Navigator.push(context, OnlineVaccineAppointmentPage.route());
        },
      ),
      // SubModule(
      //   icon: HugeIcons.strokeRoundedBulb,
      //   title: "Vaccine Recommendation",
      //   subtitle: "Get personalized vaccine recommendations.",
      //   onTap: () {},
      // ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccine'),
        leading: const AppBarBackBtn(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: vaccineServices.length,
        itemBuilder: (context, index) {
          final service = vaccineServices[index];
          return SubModuleCard(subModule: service);
        },
      ),
    );
  }
}
