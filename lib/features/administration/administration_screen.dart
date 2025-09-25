
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/dependencies/dependencies.dart';
import '../../../../core/services/shared_pref_service.dart';
import '../../../../core/utils/show_dialogue_question.dart';
import '../../../../routes.dart';
import '../../components/tab_item.dart';
import '../historique/ui/historique_screen.dart';
import '../users/ui/users_screen.dart';



class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(milliseconds: 600),
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Administration',style: GoogleFonts.aBeeZee(color:AppColors.primaryColor),),
            backgroundColor: Colors.grey[100],
            elevation: 0,
            foregroundColor: AppColors.primaryColor,
            actions: [
              IconButton(onPressed: logout, icon:const Icon(Icons.logout,color: AppColors.primaryColor,)),

            ],
            bottom:  TabBar(
              dividerColor: AppColors.primaryColor.withOpacity(0.4),
              indicator: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      bottom:
                      BorderSide(color: AppColors.primaryColor, width: 2))),
              tabs: [
                Tab(
                  child: TabItem(name: "Users",color:AppColors.primaryColor, icon: AppImages.ic_admin,),
                ),
                Tab(
                  child: TabItem(name: "Historiques", color: AppColors.primaryColor,icon: AppImages.ic_history),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              UsersScreen.page(),
              HistoriqueScreen.page()
            ],
          )
      ),
    );
  }

  void logout() async {
    var result = await showDialogueQuestion(
        context, "Voulez-vous vraiment vous déconnecter ?", "Oui", "Non");
    if (result is bool && result) {
     logout();
    }
  }


}