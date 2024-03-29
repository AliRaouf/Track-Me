part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class GetUserDataState extends UserState {}
class ReceiveUserNameSuccessState extends UserState {}
class ReceiveUserNameLoadingState extends UserState {}
class ReceiveUserNameErrorState extends UserState {}
class UserSignOutSuccessState extends UserState {}
class UserSignOutLoadingState extends UserState {}
class UserSignOutErrorState extends UserState {}
class ChangeUserPasswordSuccessState extends UserState {}
class ChangeUserPasswordLoadingState extends UserState {}
class ChangeUserPasswordErrorState extends UserState {}

