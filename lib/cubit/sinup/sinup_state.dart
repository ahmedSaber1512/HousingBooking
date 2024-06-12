part of 'sinup_cubit.dart';

@immutable
sealed class SinupState {}

final class SinupInitial extends SinupState {}

class SinupLoading extends SinupState {}

class SinupSuccess extends SinupState {}

class SinupFailure extends SinupState {
  final String error;

  SinupFailure(this.error);
}
