import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/features/home/data/models/service.dart';
import 'package:vaccine_home/features/mental_well_being/presentation/pages/mental_well_being_page.dart';
import 'package:vaccine_home/features/reminder/presentation/pages/reminder_page.dart';
import 'package:vaccine_home/features/vaccine/presentation/pages/vaccine_page.dart';
import 'package:vaccine_home/features/vaccine_card/presentation/pages/vaccine_card_page.dart';

class ServiceRepository {
  ServiceRepository._();

  static List<Service> services(BuildContext context) {
    return [
      Service(
        name: 'Vaccination',
        icon: HugeIcons.strokeRoundedId,
        onTap: () {
          Navigator.push(context, VaccineCardPage.route());
        },
      ),
      Service(
        name: 'Vaccine',
        icon: HugeIcons.strokeRoundedVaccine,
        onTap: () {
          Navigator.push(context, VaccinePage.route());
        },
      ),
      Service(
        name: 'Self-Care Alert',
        icon: HugeIcons.strokeRoundedNotification03,
        onTap: () {
          Navigator.push(context, ReminderPage.route());
        },
      ),
      Service(
        name: 'Mental Well Being',
        icon: HugeIcons.strokeRoundedBrain02,
        onTap: () {
          Navigator.push(context, MentalWellBeingPage.route());
        },
      ),
    ];
  }
}
