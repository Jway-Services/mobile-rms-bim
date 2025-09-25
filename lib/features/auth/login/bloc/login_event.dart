part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent{
  String username;
  String password;

  Login(this.username, this.password);
}
