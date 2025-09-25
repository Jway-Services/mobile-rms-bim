

import 'package:bim/core/dependencies/dependencies.dart';
import 'package:bim/core/services/shared_pref_service.dart';
import 'package:bim/features/administration/administration_screen.dart';
import 'package:bim/features/home/ui/home.dart';
import 'package:bim/features/initialiser/ui/initialiser.dart';
import 'package:bim/features/personel_historiques/ui/personel_historiques.dart';
import 'package:bim/features/rapport/ui/rapport.dart';
import 'package:go_router/go_router.dart';

import 'features/main_screen/main_screen.dart';
import 'features/screens.dart';



class Routes{

  static const String login="/login";
  static const String register="/register";
  static const String home="/home";
  static const String rapport="/";
  static const String administration="/administration";
  static const String resetPassword="/reset-password";
  static const String initializer="/initialiser";
  static const String historique="/personelHistoriques/:id";


  static GoRouter router=GoRouter(
      initialLocation: login,

      routes: [
        GoRoute(
            path: resetPassword,
            pageBuilder: (context,state)=>const NoTransitionPage(child:ResetPasswordScreen())
        ),
        GoRoute(
            path: register,
            pageBuilder: (context,state)=>const NoTransitionPage(child:RegisterScreen())
        ),
        GoRoute(
            path: login,
            redirect: (context,state){
              SharedPrefService sharedp=Dependencies.get<SharedPrefService>();
              if(sharedp.contains(SharedPrefService.token)){
                return initializer;
              }
            },
            pageBuilder: (context,state)=>NoTransitionPage(child:LoginScreen.page())
        ),
        GoRoute(
            path: initializer,
            redirect: (context,state){
              SharedPrefService sharedp=Dependencies.get<SharedPrefService>();
              if(!sharedp.contains(SharedPrefService.token)){
                return login;
              }
            },
            pageBuilder: (context,state)=>NoTransitionPage(child:Initialiser.page())
        ),
        StatefulShellRoute.indexedStack(

            builder: (context,state,shellRoute){
              return MainScreen(navigationShell: shellRoute);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: home,
                      pageBuilder: (context,state)=>NoTransitionPage(child:Home.page() )
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path:rapport ,
                      pageBuilder: (context,state){

                        return NoTransitionPage(child: RapportScreen.page());
                      }
                  ),
                ],
              ),

              StatefulShellBranch(
                routes: [
                  GoRoute(
                      path: administration,
                      pageBuilder: (context,state){
                        return NoTransitionPage(child: AdminScreen());
                      }
                  ),
                ],
              ),

            ]
        ),



        GoRoute(
            path: historique,
          pageBuilder: (context,state){
            int id=int.parse(state.pathParameters['id'].toString());
            String from=state.uri.queryParameters['from']!;
            String to=state.uri.queryParameters['to']!;
              return NoTransitionPage(child: PersonelHistorique.page(id,from,to));
          }
        )
      ]
  );

}