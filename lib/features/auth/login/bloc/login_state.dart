part of 'login_bloc.dart';




class LoginState {
  AppStatus? loginStatus;
  String? error;
  bool? isAuth;
  bool? isOffline;
  User? user;

  LoginState({
    this.loginStatus,
    this.error,
    this.isAuth,
    this.user,
    this.isOffline
  });

  LoginState copyWith({
    AppStatus? loginStatus,
    String? error,
    bool? isAuth,
    User? user,
    bool? isOffline
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      error: error ,
      isAuth: isAuth ,
      user: user ?? this.user,
      isOffline: isOffline
    );
  }
}




