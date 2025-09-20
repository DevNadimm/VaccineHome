part of 'vaccine_card_request_bloc.dart';

abstract class VaccineCardRequestEvent {}

class SubmitVaccineCardRequestEvent extends VaccineCardRequestEvent {
  final String firstNameEnglish;
  final String lastNameEnglish;
  final String gender;
  final String birthDate;
  final String father;
  final String mother;
  final String address;
  final String email;
  final String phoneNumber;
  final String whatsappImo;
  final String passportNo;
  final String birthCertificateNumber;
  final String presentNationality;

  SubmitVaccineCardRequestEvent({
    required this.firstNameEnglish,
    required this.lastNameEnglish,
    required this.gender,
    required this.birthDate,
    required this.father,
    required this.mother,
    required this.address,
    required this.email,
    required this.phoneNumber,
    required this.whatsappImo,
    required this.passportNo,
    required this.birthCertificateNumber,
    required this.presentNationality,
  });
}
