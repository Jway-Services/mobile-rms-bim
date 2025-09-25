import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../routes.dart';
import '../dependencies/dependencies.dart';
import '../services/shared_pref_service.dart';


void logout(BuildContext context){
  SharedPrefService sharedPrefService=Dependencies.get<SharedPrefService>();
  sharedPrefService.removeRecord(SharedPrefService.token);
  final router=Routes.router;
  while(router.canPop()){
    router.pop();
  }
  router.replace(Routes.login);
}