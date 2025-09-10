import 'package:flutter/cupertino.dart';
import 'package:vaccine_home/core/constants/asset_paths.dart';
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
        name: 'Reminder',
        iconPath: AssetPaths.reminderIcon,
        onTap: () {
          Navigator.push(context, ReminderPage.route());
        },
      ),
      Service(
        name: 'Vaccine',
        iconPath: AssetPaths.vaccineIcon,
        onTap: () {
          Navigator.push(context, VaccinePage.route());
        },
      ),
      Service(
        name: 'Vaccine Card',
        iconPath: AssetPaths.vaccineCardIcon,
        onTap: () {
          Navigator.push(context, VaccineCardPage.route());
        },
      ),
      Service(
        name: 'Mental Well Being',
        iconPath: AssetPaths.mentalWellBeingIcon,
        onTap: () {
          Navigator.push(context, MentalWellBeingPage.route());
        },
      ),
    ];
  }
}
