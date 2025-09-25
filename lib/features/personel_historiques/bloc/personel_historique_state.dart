part of 'personel_historique_cubit.dart';



class PersonelHistoriqueState {
  AppStatus? fetchData;
  String? error;
  Personel? personel;
  bool? isOffline;
  int? personelId;
  String? from;
  String? to;

  PersonelHistoriqueState({
    this.fetchData,
    this.error,
    this.personel,
    this.isOffline,
    this.personelId,
    this.from,
    this.to
  });

  PersonelHistoriqueState copyWith({
    AppStatus? fetchData,
    String? error,
    Personel? personel,
    bool? isOffline,
    int? personelId,
    String? from,
    String? to
  }) {
    return PersonelHistoriqueState(
      fetchData: fetchData ?? this.fetchData,
      error: error ,
      personel: personel ?? this.personel,
      isOffline: isOffline ,
      personelId: personelId ?? this.personelId,
      from: from ?? this.from,
      to: to ?? this.to
    );
  }
}
