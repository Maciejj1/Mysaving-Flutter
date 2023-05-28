part of 'apple_cubit.dart';

enum AppleStatus { initial, submitting, success, error }

class AppleState extends Equatable {
  final AppleStatus status;

  const AppleState({required this.status});

  factory AppleState.initial() {
    return const AppleState(status: AppleStatus.initial);
  }

  AppleState copyWith({AppleStatus? status}) {
    return AppleState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
