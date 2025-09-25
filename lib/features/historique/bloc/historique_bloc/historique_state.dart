part of 'historique_bloc.dart';

class HistoriqueState {

  AppStatus? fetchHistoriqueStatus;
  AppStatus? deleteHistoriqueStatus;
  String? error;
  List<Historique>? historiques;
  bool? isAuth;
  bool? isOffline;

  HistoriqueState.empty();


  HistoriqueState(
      {this.fetchHistoriqueStatus,
      this.error,
      this.historiques,
      this.isAuth,
        this.deleteHistoriqueStatus,
      this.isOffline});

  HistoriqueState copyWith({
    AppStatus? fetchHistoriqueStatus,
    AppStatus? deleteHistoriqueStatus,
    String? error,
    List<Historique>? historiques,
    bool? isAuth,
    bool? isOffline,
  }){
    return HistoriqueState(
      isOffline: isOffline,
      error: error,
      isAuth: isAuth ?? this.isAuth,
      historiques: historiques ?? this.historiques,
      fetchHistoriqueStatus: fetchHistoriqueStatus ?? this.fetchHistoriqueStatus,
      deleteHistoriqueStatus: deleteHistoriqueStatus
    );
  }



}


