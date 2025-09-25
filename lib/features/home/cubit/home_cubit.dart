import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/cubit/core_cubit.dart';
import 'package:bim/core/dependencies/dependencies.dart';
import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:bim/exceptions/network_connectivity_exception.dart';
import 'package:bim/exceptions/unauthenticated_exception.dart';
import 'package:bim/exceptions/unauthorized_exception.dart';
import 'package:bim/models/dashboard.dart';
import 'package:bim/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(from: DateTime.now().add(const Duration(days: -7)),to: DateTime.now()));


  void fetchData()async{
    try{
      emit(state.copyWith(fetchDataStatus: AppStatus.loading));
      Repository repository=Dependencies.get<Repository>();
      DashboardData dashboardData=await repository.getDashboardData(state.from.formattedDateEn, state.to.formattedDateEn);

      emit(state.copyWith(fetchDataStatus: AppStatus.success,dashboardData: dashboardData));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchDataStatus: AppStatus.error,isOffline: true));
    } catch(ex){
      emit(state.copyWith(fetchDataStatus: AppStatus.error));
      if(ex is UnAuthorizedException){
        Dependencies.get<CoreCubit>().logout();
      }
    }
  }

  void selectFrom(DateTime from){
    emit(state.copyWith(from: from));
  }
  void selectTo(DateTime to){
    emit(state.copyWith(to: to));
  }

}
