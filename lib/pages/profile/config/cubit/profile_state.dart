part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<UserProfile>? profiles;

  ProfileLoaded({this.profiles});
}

class ProfileUpdated extends ProfileState {
  final String message;

  ProfileUpdated(this.message);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
