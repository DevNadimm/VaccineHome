part of 'vaccine_card_request_bloc.dart';

abstract class VaccineCardRequestEvent {}

class SubmitVaccineCardRequestEvent extends VaccineCardRequestEvent {
  final String firstNameEnglish;
  final String? lastNameEnglish;
  final String gender;
  final String vaccinationCentre;
  final String birthDate;
  final String father;
  final String mother;
  final String phoneNumber;
  final String? whatsapp;
  final String? address;
  final String presentNationality;

  SubmitVaccineCardRequestEvent({
    required this.firstNameEnglish,
    this.lastNameEnglish,
    required this.gender,
    required this.vaccinationCentre,
    required this.birthDate,
    required this.father,
    required this.mother,
    required this.phoneNumber,
    required this.presentNationality,
    this.whatsapp,
    this.address,
  });
}
