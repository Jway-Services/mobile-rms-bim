import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState> {
  CoreCubit() : super(CoreInitial());


  void logout(){
    emit(UnautenticatedState());
  }


}
