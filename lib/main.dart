import 'package:bim/core/cubit/core_cubit.dart';
import 'package:bim/core/utils/logout.dart';
import 'package:bim/repository/data_providers/api/api_client.dart';
import 'package:bim/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'config.dart';
import 'core/dependencies/dependencies.dart';
import 'core/services/shared_pref_service.dart';
import 'core/themes/light_theme/light_theme.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
      )
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await perpareDependecies();
  runApp(const MyApp());
}

Future<void> perpareDependecies() async {
  SharedPrefService sharedPrefService = await SharedPrefService
      .initializeService();
  String? token;
  if (sharedPrefService.contains(SharedPrefService.token)) {
    token = sharedPrefService.getValue(SharedPrefService.token, "");
  }
  //print("======================================$token");
  ApiClient erpApiClient = ApiClient(
      baseUrl: baseUrl,
      token: token,

  );
  Repository repository = Repository(apiClient: erpApiClient);
  CoreCubit coreCubit = CoreCubit();
  Dependencies.put(coreCubit);
  Dependencies.put(repository);
  Dependencies.put(sharedPrefService);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: Dependencies.get<CoreCubit>(),
      listener: (cxt, state) {
        if(state is UnautenticatedState){
          logout(cxt);
        }
      },
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: MaterialApp.router(
          title: 'Cantine',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          routerConfig: Routes.router,
        ),
      ),
    );
  }
}
