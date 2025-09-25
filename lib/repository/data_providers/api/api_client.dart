

import 'dart:io';

import 'package:bim/exceptions/unauthenticated_exception.dart';
import 'package:bim/models/dashboard.dart';
import 'package:bim/models/personel.dart';
import 'package:bim/models/rapport_response.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../../../exceptions/network_connectivity_exception.dart';
import '../../../exceptions/server_exception.dart';
import '../../../exceptions/unauthorized_exception.dart';
import '../../../models/historique.dart';
import '../../../models/user.dart';

class ApiClient {

  late Dio _dio;


  ApiClient({
    required String baseUrl,
    String? baseUrlForAppVersion
,    String? token
  }) {
    _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        contentType: "application/json",
        connectTimeout: const Duration(seconds: 20),
        headers: token != null ? {
          "Authorization": "Bearer ${token}"
        } : null
    ))
      ..interceptors.add(
          LogInterceptor(error: true,
              request: true,
              requestBody: true,
              responseBody: true,
              requestHeader: true,
              responseHeader: true)
      );



  }


  
  Future<User> login(String username, String password,String from) async {
    try {
      var response = await _dio.post(
          "/login",
          data: {
            "username": username,
            "password": password,
            "from": from
          });
      User userModel = User.fromJson(response.data);
      return userModel;
    } on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode ?? 0) == 401) {
        throw UnAuthenticatedException();
      }

      rethrow;
    }
  }


  
  Future<User> me({String? from}) async {
    try {
      var response = await _dio.get(
          "/me", queryParameters: from == null ? null : {"from": from});
      User userModel = User.fromJson(response.data);
      return userModel;
    } on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      rethrow;
    }
  }
  
  
  Future<RapportResponse> getPersonel(String from,String to)async{
    try {
      var response=await _dio.get(
        "/personnel",
        queryParameters: {
          "from":from,
          "to":to
        }
      );
      RapportResponse rapportResponse=RapportResponse.fromJson(response.data);
      return rapportResponse;
    } on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      rethrow;
    }
  }


  Future<Personel> getPersonelHistoriques(int id,String from,String to)async{
    try {
      var response=await _dio.get(
          "/repas/historique/${id}",
          queryParameters: {
            "from":from,
            "to":to
          }
      );
      Personel p=Personel.fromJson(response.data);
      return p;
    } on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      rethrow;
    }
  }

  @override
  Future<List<Historique>> getHistoriques(String from,String to) async{
    try{
      var response=await _dio.get("/historiques",queryParameters: {"from":from,"to":to});
      List<Historique> historiques=(response.data as List).map((json) =>Historique.fromJson(json) ).toList();
      return historiques;
    }on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      rethrow;
    }
  }

  @override
  Future<void> deleteHistorique(String id) async{
    try{
      var response=await _dio.delete("/historiques/$id");
    }on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      if (ex.response?.data != null) {
        throw ServerException(ex.response!.data as String);
      }
      rethrow;
    }
  }

  @override
  Future<List<User>> getUsers() async{
    try{
      var response=await _dio.get('/users');
      List<User> users=(response.data as List).map((json) => User.fromJson(json)).toList();
      return users;
    }on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      if (ex.response?.data != null) {
        throw ServerException(ex.response!.data as String);
      }
      rethrow;
    }
  }

  @override
  Future<DashboardData> getDashboardData(String from,String to) async{
    try{
        var response=await _dio.get("/repas/statistiques",
        queryParameters: {
          "from":from,
          "to":to
        });
        DashboardData dashboardData=DashboardData.fromJson(response.data);
        return dashboardData;
    }on DioException catch (ex) {
      if (ex.error is SocketException ||
          ex.type == DioExceptionType.connectionTimeout) {
        throw NetworkConnectivityException();
      }
      if ((ex.response?.statusCode??0) == 401) {
        throw UnAuthenticatedException();
      }
      if ((ex.response?.statusCode??0) == 403) {
        throw UnAuthorizedException();
      }
      if (ex.response?.data != null) {
        throw ServerException(ex.response!.data as String);
      }
      rethrow;
    }
  }


  
  
}