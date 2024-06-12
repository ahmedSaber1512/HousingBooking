part of 'profil_cubit.dart';

@immutable
sealed class ProfilState {}

final class ProfilInitial extends ProfilState {}
 class ProfileLoading extends ProfilState {}

   class ProfileImagePicked extends ProfilState {
     final File image;
     ProfileImagePicked(this.image);
   }

   class ProfileUpdated extends ProfilState {}

   class ProfileError extends ProfilState {
     final String message;
     ProfileError(this.message);
   }