import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccine_home/features/home/data/models/popup_banner_model.dart';
import 'package:vaccine_home/features/home/data/repositories/popup_banner_repository.dart';

part 'popup_banner_event.dart';
part 'popup_banner_state.dart';

class PopupBannerBloc extends Bloc<PopupBannerEvent, PopupBannerState> {
  PopupBannerBloc() : super(PopupBannerInitial()) {
    on<CheckPopupBannerEvent>(_onCheckPopupBanner);
    on<ReadPopupBannerEvent>(_onReadPopupBanner);
  }

  Future<void> _onCheckPopupBanner(
    CheckPopupBannerEvent event,
    Emitter<PopupBannerState> emit,
  ) async {
    emit(PopupBannerLoading());
    try {
      final popupBanner = await PopupBannerRepository.fetchPopupBanner();
      if (popupBanner != null) {
        emit(PopupBannerLoaded(popupBanner));
      } else {
        emit(PopupBannerNoData());
      }
    } catch (e) {
      emit(PopupBannerFailure(e.toString()));
    }
  }

  Future<void> _onReadPopupBanner(
    ReadPopupBannerEvent event,
    Emitter<PopupBannerState> emit,
  ) async {
    if (state is PopupBannerLoaded) {
      final currentState = state as PopupBannerLoaded;

      emit(PopupBannerNoData());

      try {
        await PopupBannerRepository.markPopupAsRead(event.id.toString());
      } catch (e) {
        emit(PopupBannerFailure('Failed to mark banner as read'));
        emit(PopupBannerLoaded(currentState.banner));
      }
    }
  }
}
