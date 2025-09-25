part of 'initialiser_cubit.dart';



class InitialiserState {
  AppStatus? fetchData;
  String? error;
  String? destination;
  bool? isOffline;
  bool? isAuth;

  InitialiserState({
    this.fetchData,
    this.error,
    this.isOffline,
    this.isAuth,
    this.destination,

  });

  InitialiserState copyWith({
    AppStatus? fetchData,
    String? error,
    bool? isOffline,
    bool? isAuth,
    String? destination
  }) {
    return InitialiserState(
      fetchData: fetchData ?? this.fetchData,
      error: error ,
      isOffline: isOffline ,
      isAuth: isAuth ,
      destination: destination ?? this.destination
    );
  }
}


