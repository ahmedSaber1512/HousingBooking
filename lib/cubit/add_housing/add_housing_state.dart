part of 'add_housing_cubit.dart';

@immutable
sealed class AddHousingState {}

final class AddHousingInitial extends AddHousingState {}
class AddHousingLoading extends AddHousingState {}
class UplodeImage extends AddHousingState {}

class AddHousingSuccess extends AddHousingState {
  final String successMessage;
  AddHousingSuccess(this.successMessage);
}

class AddHousingError extends AddHousingState {
  final String errorMessage;
  AddHousingError(this.errorMessage);
}

class UserPhoneLoaded extends AddHousingState {
  final String phone;
  UserPhoneLoaded(this.phone);
}

class ImagePickedSuccess extends AddHousingState {
  final int imageIndex;
  ImagePickedSuccess(this.imageIndex);
}

class ImagePickError extends AddHousingState {
  final String error;
  ImagePickError(this.error);
}

class UploadImageError extends AddHousingState {
  final String error;
  UploadImageError(this.error);
}