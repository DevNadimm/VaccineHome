part of 'advertisement_bloc.dart';

abstract class AdvertisementState {}

class AdvertisementInitial extends AdvertisementState {}

class AdvertisementLoading extends AdvertisementState {}

class AdvertisementSuccess extends AdvertisementState {
  final AdvertisementModel model;
  AdvertisementSuccess(this.model);
}

class AdvertisementFailure extends AdvertisementState {
  final String message;
  AdvertisementFailure(this.message);
}
