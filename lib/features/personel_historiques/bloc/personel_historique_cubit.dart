import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/dependencies/dependencies.dart';
import 'package:bim/exceptions/network_connectivity_exception.dart';
import 'package:bim/models/personel.dart';
import 'package:bim/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/cubit/core_cubit.dart';
import '../../../exceptions/unauthorized_exception.dart';

part 'personel_historique_state.dart';

class PersonelHistoriqueCubit extends Cubit<PersonelHistoriqueState> {
  PersonelHistoriqueCubit(int personel,String from,String to)
      : super(PersonelHistoriqueState(personelId: personel,from: from,to: to));


  void fetchData() async{
    try{
      emit(state.copyWith(fetchData: AppStatus.loading));
      Repository repository=Dependencies.get<Repository>();
      Personel personel=await repository.getPersonel(state.personelId!, state.from!, state.to!);
      emit(state.copyWith(fetchData: AppStatus.success,personel: personel));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchData: AppStatus.error,isOffline: true));
    }catch(ex){
      emit(state.copyWith(fetchData: AppStatus.success));
      if(ex is UnAuthorizedException){
        Dependencies.get<CoreCubit>().logout();
      }
    }
  }


}
