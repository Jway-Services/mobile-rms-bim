import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/dependencies/dependencies.dart';
import 'package:bim/exceptions/network_connectivity_exception.dart';
import 'package:bim/exceptions/unauthenticated_exception.dart';
import 'package:bim/models/user.dart';
import 'package:bim/repository/repository.dart';
import 'package:bloc/bloc.dart';

import '../../../routes.dart';

part 'initialiser_state.dart';

class InitialiserCubit extends Cubit<InitialiserState> {
  InitialiserCubit() : super(InitialiserState());
  
  
  
  void fetchData()async{
    try{
      emit(state.copyWith(fetchData: AppStatus.loading));
      Repository repository=Dependencies.get<Repository>();

      User user=await repository.me();
      Dependencies.put(user);
      emit(state.copyWith(fetchData: AppStatus.success,destination: Routes.rapport));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchData: AppStatus.error,isOffline: true));
    }on UnAuthenticatedException catch (ex){
      emit(state.copyWith(fetchData: AppStatus.error,isAuth: false));
    }catch(ex){
      emit(state.copyWith(fetchData: AppStatus.error));
      rethrow;
    }
  }
  
  
  
}
