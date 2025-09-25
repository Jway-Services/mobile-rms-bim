
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/dialogue_infos.dart';
import '../../../components/error_widget.dart';
import '../../../components/offline_widget.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/enums/app_status.dart';
import '../../../core/dependencies/dependencies.dart';
import '../../../core/services/shared_pref_service.dart';
import '../../../core/utils/show_dialogue_infos.dart';
import '../../../core/utils/show_dialogue_question.dart';
import '../../../core/utils/show_progress_dialogue.dart';
import '../../../models/historique.dart';
import '../../../repository/repository.dart';
import '../../../routes.dart';
import '../bloc/historique_bloc/historique_bloc.dart';
import 'components/historique_item.dart';


class HistoriqueScreen extends StatefulWidget {
  static Widget page() {
    SharedPrefService sharedPrefService=Dependencies.get<SharedPrefService>();
    Repository repository=Dependencies.get<Repository>();
    return BlocProvider<HistoriqueBloc>(
      create: (context) => HistoriqueBloc(sharedPrefService: sharedPrefService,repository: repository),
      child: HistoriqueScreen(),
    );
  }

  const HistoriqueScreen({Key? key}) : super(key: key);

  @override
  State<HistoriqueScreen> createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchHistoriques();
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          BlocListener<HistoriqueBloc,HistoriqueState>(
              listener: historiqueListener,
              child: const SizedBox(),
          ),
          Expanded(
            child: BlocBuilder<HistoriqueBloc,HistoriqueState>(
              builder: (context,state){
                if(state.fetchHistoriqueStatus==AppStatus.loading){
                  return ListView(
                    children: List.generate(4, (index) => HistoriqueItem(isLoading: true,)),
                  );
                }else if(state.fetchHistoriqueStatus==AppStatus.success){
                  return ListView(
                    children:List.generate(state.historiques!.length, (index) => HistoriqueItem(onDelete: deleteHistorique,historique: state.historiques!.elementAt(index),))
                  );
                }else if(state.fetchHistoriqueStatus==AppStatus.error){
                  if(state.isOffline ?? false){
                    return OfflineWidget(action: AppStrings.tryAgain, msg: AppStrings.checkConnectivity,actionCLick: fetchHistoriques,);
                  }else{
                    return MyErrorWidget(error: state.error ?? "Error", action: AppStrings.tryAgain,actionCLick: fetchHistoriques,);
                  }
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void deleteHistorique(Historique historique)async{
    bool? result=await showDialogueQuestion(context, "Voulez-vous vraiment supprimer cet historique ?","Oui","Non");
    if(result ?? false){
      BlocProvider.of<HistoriqueBloc>(context).add(DeleteHistorique(historique));
    }
  }

  void fetchHistoriques() {
    BlocProvider.of<HistoriqueBloc>(context).add(FetchHistorique());
  }

  void historiqueListener(BuildContext context, HistoriqueState state) {
    if(state.fetchHistoriqueStatus==AppStatus.error && !(state.isAuth??true) ){
      while(Navigator.canPop(context)){
        Navigator.pop(context);
      }
      GoRouter.of(context).replace(Routes.login);
    }

    if(state.deleteHistoriqueStatus==AppStatus.loading){
      showProgressBar(context);
    }else if(state.deleteHistoriqueStatus==AppStatus.error){
      hideDialogue(context);
      showInfoDialogue(MessageUi(state.error ?? "Error", AppStatus.error, "Okay"), context, () { hideDialogue(context);});
    }else if(state.deleteHistoriqueStatus==AppStatus.success){
      hideDialogue(context);
      showInfoDialogue(MessageUi("Success", AppStatus.success, "OKay"), context, () {hideDialogue(context); });
    }

  }
}
