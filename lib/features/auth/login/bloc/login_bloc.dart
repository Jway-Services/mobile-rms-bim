import 'dart:async';
import 'dart:io';

import 'package:bim/config.dart';
import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/dependencies/dependencies.dart';
import 'package:bim/core/services/shared_pref_service.dart';
import 'package:bim/exceptions/network_connectivity_exception.dart';
import 'package:bim/exceptions/unauthenticated_exception.dart';
import 'package:bim/models/user.dart';
import 'package:bim/repository/data_providers/api/api_client.dart';
import 'package:bim/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<Login>(_login);
  }

  FutureOr<void> _login(Login event, Emitter<LoginState> emit) async{
    try{
      emit(state.copyWith(loginStatus: AppStatus.loading));
      Repository repository=Dependencies.get<Repository>();
      String from;
      if(Platform.isAndroid){
        from="Android";
      }else{
        from="IOS";
      }
      User user=await repository.login(event.username, event.password, from);
      Dependencies.put(user);
      SharedPrefService sharedPrefService=Dependencies.get<SharedPrefService>();
      sharedPrefService.putValue(SharedPrefService.token, user.token);
      Repository newRepo=Repository(apiClient: ApiClient(baseUrl: baseUrl,token: user.token));
      Dependencies.put(newRepo);
      emit(state.copyWith(loginStatus: AppStatus.success,user: user));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(loginStatus: AppStatus.error,isOffline: true));
    }on UnAuthenticatedException catch(ex){
      emit(state.copyWith(loginStatus: AppStatus.error,isAuth: false));
    }catch (ex){
      emit(state.copyWith(loginStatus: AppStatus.error));
      rethrow;
    }
  }
}
