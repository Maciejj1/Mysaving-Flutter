import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../config/repository/auth_repository.dart';

part 'apple_state.dart';

class AppleCubit extends Cubit<AppleState> {
  final AuthRepository _authRepository;
  AppleCubit(this._authRepository) : super(AppleState.initial());

  Future<void> signUpFormSubmitted() async {
    if (state.status == AppleStatus.submitting) return;
    emit(state.copyWith(status: AppleStatus.submitting));
    try {
      await _authRepository.appleSingIn();
      emit(state.copyWith(status: AppleStatus.success));
    } catch (_) {}
  }
}
