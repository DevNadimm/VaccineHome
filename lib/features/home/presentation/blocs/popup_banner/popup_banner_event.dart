part of 'popup_banner_bloc.dart';

abstract class PopupBannerEvent {}

class CheckPopupBannerEvent extends PopupBannerEvent {}

class ReadPopupBannerEvent extends PopupBannerEvent {
  final int id;

  ReadPopupBannerEvent(this.id);
}