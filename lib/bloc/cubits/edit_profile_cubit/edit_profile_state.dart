part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class EditProfilePictureState extends EditProfileState {final String base64Image;

EditProfilePictureState(this.base64Image);}

class  EditNameState extends EditProfileState {}

class  EditEmailState extends EditProfileState {}

class  EditpasswordState extends EditProfileState {}

class SelectLogoutState extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String error;

  EditProfileError(this.error);
}

class EditProfileSuccess extends EditProfileState {

  EditProfileSuccess();
}