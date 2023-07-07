part of 'theme_bloc.dart';

abstract class DarkModeEvent extends Equatable {
  const DarkModeEvent();

  @override
  List<Object> get props => [];
}

class ToggleDarkModeEvent extends DarkModeEvent {}
