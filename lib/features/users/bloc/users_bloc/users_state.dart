part of 'users_bloc.dart';

class UsersState {

  AppStatus? fetchUsersStatus;
  String? error;
  List<User>? users;
  bool isAuth=true;
  bool? isOffline;


  UsersState.empty();

  UsersState(
      {this.fetchUsersStatus,
      this.error,
      this.users,
      required this.isAuth,
      this.isOffline});

  UsersState copyWith({
    AppStatus? fetchUsersStatus,
    List<User>? users,
    bool? isAuth,
    bool? isOffline,
    String?error,}){
    return UsersState(
        isAuth: isAuth ?? this.isAuth,
      error: error,
      isOffline: isOffline,
      users: users,
      fetchUsersStatus: fetchUsersStatus ?? this.fetchUsersStatus
    );
  }


}

