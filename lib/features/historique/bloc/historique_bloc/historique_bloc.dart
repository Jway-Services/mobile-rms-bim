import 'dart:async';

import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/enums/app_status.dart';
import '../../../../core/cubit/core_cubit.dart';
import '../../../../core/dependencies/dependencies.dart';
import '../../../../core/services/shared_pref_service.dart';
import '../../../../exceptions/network_connectivity_exception.dart';
import '../../../../exceptions/unauthorized_exception.dart';
import '../../../../models/historique.dart';
import '../../../../repository/repository.dart';


part 'historique_event.dart';
part 'historique_state.dart';

class HistoriqueBloc extends Bloc<HistoriqueEvent, HistoriqueState> {

  Repository repository;
  SharedPrefService sharedPrefService;

  HistoriqueBloc({required this.sharedPrefService,required this.repository}) : super(HistoriqueState.empty()) {

    on<FetchHistorique>(_fetchHistorique);
    on<DeleteHistorique>(_deleteHistorique);
  }

  FutureOr<void> _fetchHistorique(FetchHistorique event, Emitter<HistoriqueState> emit) async{
    try{
      emit(state.copyWith(fetchHistoriqueStatus: AppStatus.loading));
      String from=DateTime.now().add(const Duration(days: -30)).formattedDateEn;
      String to=DateTime.now().formattedDateEn;
      List<Historique> historiques=await repository.getHistoriques(from,to);
      emit(state.copyWith(fetchHistoriqueStatus: AppStatus.success,historiques: historiques));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchHistoriqueStatus: AppStatus.error,isOffline: true));
    }catch(ex){
      emit(state.copyWith(fetchHistoriqueStatus: AppStatus.error,error: "Error"));
      if(ex is UnAuthorizedException){
        print("===========logout===========");
        Dependencies.get<CoreCubit>().logout();
      }
    }
  }

  FutureOr<void> _deleteHistorique(DeleteHistorique event, Emitter<HistoriqueState> emit) async{
    try{
      emit(state.copyWith(deleteHistoriqueStatus: AppStatus.loading));
      await repository.deleteHistorique(event.historiqueEntity.id!);
      state.historiques!.remove(event.historiqueEntity);
      emit(state.copyWith(deleteHistoriqueStatus: AppStatus.success));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchHistoriqueStatus: AppStatus.error,isOffline: true));
    }catch(ex){
      emit(state.copyWith(fetchHistoriqueStatus: AppStatus.error,error: "Error"));
      if(ex is UnAuthorizedException){
        Dependencies.get<CoreCubit>().logout();
      }
    }
  }
}
