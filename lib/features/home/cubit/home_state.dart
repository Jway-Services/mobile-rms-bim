part of 'home_cubit.dart';




class HomeState {

  AppStatus? fetchDataStatus;
  String? error;
  DashboardData? dashboardData;
  bool? isOffline;
  DateTime from;
  DateTime to;

  HomeState({
    this.fetchDataStatus,
    this.error,
    this.dashboardData,
    this.isOffline,
    required this.from,
    required this.to
  });

  HomeState copyWith({
    AppStatus? fetchDataStatus,
    String? error,
    DashboardData? dashboardData,
    bool? isOffline,
    DateTime? from,
    DateTime? to
  }) {
    return HomeState(
      fetchDataStatus: fetchDataStatus ?? this.fetchDataStatus,
      error: error ,
      dashboardData: dashboardData ?? this.dashboardData,
      isOffline: isOffline ,
      to: to ??this.to,
      from: from??this.from
    );
  }
}


