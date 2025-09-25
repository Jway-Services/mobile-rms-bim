import 'package:bim/components/error_offline_widget.dart';
import 'package:bim/components/loading_widget.dart';
import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/utils/logout.dart';
import 'package:bim/features/initialiser/cubit/initialiser_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../routes.dart';





class Initialiser extends StatefulWidget {
  const Initialiser({Key? key}) : super(key: key);

  static Widget page(){
    return BlocProvider<InitialiserCubit>(
        create: (context)=>InitialiserCubit(),
      child: Initialiser(),
    );
  }


  @override
  State<Initialiser> createState() => _InitialiserState();
}

class _InitialiserState extends State<Initialiser> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocListener<InitialiserCubit,InitialiserState>(
              listener: listener,
            child: SizedBox(),
          ),
          Expanded(
            child: BlocBuilder<InitialiserCubit,InitialiserState>(
              builder: (context,state){
                if(state.fetchData==AppStatus.loading){
                  return  Center(
                    child: LoadingWidget(),
                  ) ;
                }else if(state.fetchData==AppStatus.error){
                  return OfflineErrodWidget(isOffline: state.isOffline??false,action: fetchData,error: state.error,);
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void fetchData() {
    BlocProvider.of<InitialiserCubit>(context).fetchData();
  }

  void listener(BuildContext context, InitialiserState state) {
    if(state.fetchData==AppStatus.success){
      while(GoRouter.of(context).canPop()){
        GoRouter.of(context).pop();
      }
      GoRouter.of(context).replace(state.destination!);
    }else if(state.fetchData==AppStatus.error){
      logout(context);
    }

  }
}
