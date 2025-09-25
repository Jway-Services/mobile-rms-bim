part of 'personel_cubit.dart';



class PersonelState {
  AppStatus? fetchStatus;
  String? error;
  bool? isOffline;
  bool? isAuth;
  RapportResponse? rapportResponse;
  DateTime? from;
  DateTime? to;

  PersonelState({
    this.fetchStatus,
    this.error,
    this.isOffline,
    this.isAuth,
     this.rapportResponse,
    this.from,
    this.to
  });

  PersonelState copyWith({
    AppStatus? fetchStatus,
    String? error,
    bool? isOffline,
    bool? isAuth,
    RapportResponse? rapportResponse,
    DateTime? from,
    DateTime? to,
  }) {

    return PersonelState(
      fetchStatus: fetchStatus ?? this.fetchStatus,
      error: error ,
      isOffline: isOffline ,
      isAuth: isAuth ,
      rapportResponse: rapportResponse ?? this.rapportResponse,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }
}

