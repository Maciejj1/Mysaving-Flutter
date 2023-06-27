part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class AppLogoutRequested extends AppEvent {}

class AppUserChangedEvent extends AppEvent {
  final User user;

  AppUserChangedEvent(this.user);

  @override
  List<Object?> get props => [user];
}
