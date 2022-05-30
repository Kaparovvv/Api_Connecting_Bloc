part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoadingState extends UserState {}

class UserErrorState extends UserState {
  final String error;

  UserErrorState({required this.error});
}

class UserLoadedState extends UserState {
  final UserModel userModel;

  UserLoadedState({required this.userModel});
}
