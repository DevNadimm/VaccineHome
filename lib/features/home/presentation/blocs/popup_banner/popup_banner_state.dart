part of 'popup_banner_bloc.dart';

abstract class PopupBannerState {}

class PopupBannerInitial extends PopupBannerState {}

class PopupBannerLoading extends PopupBannerState {}

class PopupBannerLoaded extends PopupBannerState {
  final PopupBannerData banner;

  PopupBannerLoaded(this.banner);
}

class PopupBannerNoData extends PopupBannerState {}

class PopupBannerFailure extends PopupBannerState {
  final String message;

  PopupBannerFailure(this.message);
}