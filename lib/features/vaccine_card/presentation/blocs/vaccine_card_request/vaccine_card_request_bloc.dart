import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/core/utils/helper_functions/exception_formatter.dart';
import 'package:vaccine_home/features/vaccine_card/data/repositories/vaccine_card_request_repository.dart';

part 'vaccine_card_request_event.dart';
part 'vaccine_card_request_state.dart';

class VaccineCardRequestBloc extends Bloc<VaccineCardRequestEvent, VaccineCardRequestState> {
  VaccineCardRequestBloc() : super(VaccineCardRequestInitial()) {
    on<SubmitVaccineCardRequestEvent>(_onSubmitVaccineCardRequest);
  }

  Future<void> _onSubmitVaccineCardRequest(
    SubmitVaccineCardRequestEvent event,
    Emitter<VaccineCardRequestState> emit,
  ) async {
    emit(VaccineCardRequestLoading());
    try {
      final res = await VaccineCardRequestRepository.requestVaccineCard(
        firstNameEnglish: event.firstNameEnglish,
        lastNameEnglish: event.lastNameEnglish,
        gender: event.gender,
        birthDate: event.birthDate,
        father: event.father,
        mother: event.mother,
        address: event.address,
        email: event.email,
        phoneNumber: event.phoneNumber,
        whatsappImo: event.whatsappImo,
        passportNo: event.passportNo,
        birthCertificateNumber: event.birthCertificateNumber,
        presentNationality: event.presentNationality,
      );
      if (res) {
        emit(VaccineCardRequestSuccess());
      } else {
        emit(VaccineCardRequestFailure("Unknown error occurred"));
      }
    } catch (e) {
      emit(VaccineCardRequestFailure(ExceptionFormatter.format(e)));
    }
  }
}
