import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mysavingapp/config/repository/apple_repository.dart';

import '../../../../../config/repository/auth_repository.dart';

part 'apple_state.dart';

class AppleCubit extends Cubit<AppleState> {
  final AppleRepository _appleRepository;
  AppleCubit(this._appleRepository) : super(AppleState.initial());

  Future<void> signUpFormSubmitted() async {
    if (state.status == AppleStatus.submitting) return;
    emit(state.copyWith(status: AppleStatus.submitting));
    try {
      await _appleRepository.signInWithAppleAndRedirectToDashboard();
      emit(state.copyWith(status: AppleStatus.success));
    } catch (_) {}
  }
}
