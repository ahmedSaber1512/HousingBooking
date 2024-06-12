part of 'booking_housing_cubit.dart';

@immutable
sealed class BookingHousingState {}

final class BookingHousingInitial extends BookingHousingState {}
class OrderProcessing extends BookingHousingState {}

class OrderSuccess extends BookingHousingState {
  final String message;
  OrderSuccess(this.message);
}

class OrderFailure extends BookingHousingState {
  final String error;
  OrderFailure(this.error);
}