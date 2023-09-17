part of 'login_model_bloc.dart';

@immutable
abstract class LoginModelState {}

class LoginModelInitial extends LoginModelState {}

class UserLoginSuccessState extends LoginModelState{

}
class UserLoginErrorState extends LoginModelState{

}
class UserLoginLoadingState extends LoginModelState{}


class UserLogOutSuccessState extends LoginModelState{

}
class UserLogOutErrorState extends LoginModelState{


}
class UserLogOutLoadingState extends LoginModelState{}