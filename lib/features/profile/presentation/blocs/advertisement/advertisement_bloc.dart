import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/profile/data/models/advertisement_model.dart';
import 'package:vaccine_home/features/profile/data/repositories/advertisement_repository.dart';

part 'advertisement_event.dart';
part 'advertisement_state.dart';

class AdvertisementBloc extends Bloc<AdvertisementEvent, AdvertisementState> {
  AdvertisementBloc() : super(AdvertisementInitial()) {
    on<FetchAdvertisementsEvent>(_onFetchAdvertisements);
  }

  Future<void> _onFetchAdvertisements(
    FetchAdvertisementsEvent event,
    Emitter<AdvertisementState> emit,
  ) async {
    emit(AdvertisementLoading());

    try {
      final ads = await AdvertisementRepository.getAdvertisements();
      emit(AdvertisementSuccess(ads));
    } catch (e) {
      emit(AdvertisementFailure(e.toString()));
    }
  }
}
