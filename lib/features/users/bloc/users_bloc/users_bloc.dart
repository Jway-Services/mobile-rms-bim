import 'dart:async';

import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/enums/app_status.dart';
import '../../../../core/cubit/core_cubit.dart';
import '../../../../core/dependencies/dependencies.dart';
import '../../../../core/services/shared_pref_service.dart';
import '../../../../exceptions/network_connectivity_exception.dart';
import '../../../../exceptions/unauthenticated_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../models/user.dart';
import '../../../../repository/repository.dart';


part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  SharedPrefService sharedPrefService;
  Repository repository;


  UsersBloc({required this.repository,required this.sharedPrefService}) : super(UsersState.empty()) {

    on<FetchUsers>(_fetchUsers);
  }

  FutureOr<void> _fetchUsers(FetchUsers event, Emitter<UsersState> emit)async {
    try{
      emit(state.copyWith(fetchUsersStatus: AppStatus.loading));
      List<User> users=await repository.getUsers();
      emit(state.copyWith(fetchUsersStatus: AppStatus.success,users: users));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchUsersStatus: AppStatus.error,isOffline: true));
    }catch(ex){
      emit(state.copyWith(fetchUsersStatus: AppStatus.error,error: ex.toString()));
      if(ex is UnAuthorizedException){
        Dependencies.get<CoreCubit>().logout();
      }
    }
  }
}
