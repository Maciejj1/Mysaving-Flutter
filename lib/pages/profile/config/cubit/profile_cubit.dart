import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mysavingapp/config/repository/interfaces/IProfileRepository.dart';
import 'package:mysavingapp/config/repository/profile_repository.dart';

import '../../../../config/models/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({IProfileRepository? profileRepository})
      : _profileRepository = profileRepository ?? ProfileRepository(),
        super(ProfileInitial());
  final IProfileRepository _profileRepository;

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final results = await _profileRepository.getProfile();
    emit(ProfileLoaded(profiles: results));
  }

  void updateEmail(String newEmail) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.updateEmail(newEmail);
      emit(ProfileUpdated('Email updated successfully.'));
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      print(e.toString());
      emit(ProfileError('Failed to update email.'));
    }
  }

  void updatePassword(String newPassword) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.updatePassword(newPassword);
      emit(ProfileUpdated('Password updated successfully.'));
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      print(e.toString());
      emit(ProfileError('Failed to update password.'));
    }
  }

  void updateName(String newName) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.updateName(newName);
      emit(ProfileUpdated('Name updated successfully.'));
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      print(e.toString());
      emit(ProfileError('Failed to update name.'));
    }
  }

  void updateProfilePicture(String imagePath) async {
    emit(ProfileLoading());
    try {
      await _profileRepository.updateProfilePicture(imagePath);
      emit(ProfileUpdated('Profile picture updated successfully.'));
    } catch (e, stacktrace) {
      print(stacktrace.toString());
      print(e.toString());
      emit(ProfileError('Failed to update profile picture.'));
    }
  }
}
