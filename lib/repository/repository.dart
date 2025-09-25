


import 'package:bim/models/personel.dart';
import 'package:bim/models/rapport_response.dart';
import 'package:bim/repository/data_providers/api/api_client.dart';

import '../models/dashboard.dart';
import '../models/historique.dart';
import '../models/user.dart';

class Repository{


  ApiClient apiClient;

  Repository({
    required this.apiClient,
  });


  Future<User> login(String username,String password,String from)async{
    User user=await apiClient.login(username, password, from);
    return user;
  }

  Future<User> me()async{
    User user=await apiClient.me();
    return user;
  }

  Future<RapportResponse> getPersonels(String from,String to)async{
    RapportResponse personels=await apiClient.getPersonel(from, to);
    return personels;
  }
  Future<Personel> getPersonel(int id,String from,String to)async{
    Personel personel=await apiClient.getPersonelHistoriques(id,from, to);
    return personel;
  }


  @override
  Future<List<Historique>> getHistoriques(String from,String to) async{
    List<Historique> historiques=await apiClient.getHistoriques(from,to);
    return historiques;
  }

  @override
  Future<void> deleteHistorique(String id) async{
    await apiClient.deleteHistorique(id);
  }

  @override
  Future<List<User>> getUsers() async{
    List<User> users=await apiClient.getUsers();
    return users;
  }

  Future<DashboardData> getDashboardData(String from,String to)async{
    DashboardData dashboardData=await apiClient.getDashboardData(from, to);
    return dashboardData;
  }



}