part of 'theme_bloc.dart';

abstract class DarkModeState extends Equatable {
  const DarkModeState();

  @override
  List<Object> get props => [];
}

class DarkModeInitial extends DarkModeState {}

class DarkModeChanged extends DarkModeState {
  final bool isDarkMode;

  DarkModeChanged(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}
