import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/dependencies/dependencies.dart';
import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:bim/exceptions/network_connectivity_exception.dart';
import 'package:bim/features/rapport/ui/rapport.dart';
import 'package:bim/models/rapport_response.dart';
import 'package:bim/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/cubit/core_cubit.dart';
import '../../../exceptions/unauthorized_exception.dart';
import '../../../models/personel.dart';

part 'personel_state.dart';

class PersonelCubit extends Cubit<PersonelState> {
  PersonelCubit() : super(PersonelState(
    from: DateTime.now().add(const Duration(days: -30)),
    to: DateTime.now(),
  ));


  void fetchData()async{
    try{
      emit(state.copyWith(fetchStatus: AppStatus.loading));
      Repository repository=Dependencies.get<Repository>();
      RapportResponse personels=await repository.getPersonels(state.from!.formattedDateEn, state.to!.formattedDateEn);
      emit(state.copyWith(fetchStatus: AppStatus.success,rapportResponse: personels));
    }on NetworkConnectivityException catch(ex){
      emit(state.copyWith(fetchStatus: AppStatus.error,isOffline: true,error: "offline"));
    }catch(ex){
      emit(state.copyWith(fetchStatus: AppStatus.error,error:"Error" ));
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
