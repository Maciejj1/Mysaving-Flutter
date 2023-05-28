import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/repository/auth_repository.dart';

part 'google_state.dart';

class GoogleCubit extends Cubit<GoogleState> {
  final AuthRepository _authRepository;
  GoogleCubit(this._authRepository) : super(GoogleState.initial());

  Future<void> signUpFormSubmitted() async {
    if (state.status == GoogleStatus.submitting) return;
    emit(state.copyWith(status: GoogleStatus.submitting));
    try {
      await _authRepository.signInWithGoogle();
      emit(state.copyWith(status: GoogleStatus.success));
    } catch (_) {}
  }
}
