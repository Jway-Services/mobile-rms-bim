import 'package:bim/components/circle_image.dart';
import 'package:bim/components/error_offline_widget.dart';
import 'package:bim/core/constants/app_colors.dart';
import 'package:bim/core/constants/app_images.dart';
import 'package:bim/core/constants/app_strings.dart';
import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:bim/core/utils/logout.dart';
import 'package:bim/core/utils/show_dialogue_question.dart';
import 'package:bim/features/rapport/cubit/personel_cubit.dart';
import 'package:bim/models/personel.dart';
import 'package:bim/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/custom_button.dart';
import '../../../components/form_field.dart';
import '../../../core/constants/enums/app_status.dart';

class RapportScreen extends StatefulWidget {
  RapportScreen({Key? key}) : super(key: key);

  static Widget page() {
    return BlocProvider<PersonelCubit>(
      create: (context) => PersonelCubit(),
      child: RapportScreen(),
    );
  }

  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text('Rapports',style: GoogleFonts.aBeeZee(color:AppColors.primaryColor),),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
          actions: [
            IconButton(onPressed: onLogout, icon: const Icon(Icons.logout,color: AppColors.primaryColor,))
          ],
        ),
        body: BlocBuilder<PersonelCubit, PersonelState>(
          builder: (context, state) {
            final cubit = context.read<PersonelCubit>();
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [


                  Row(
                    children: [
                      Expanded(
                          child: MyFormField(
                            label: "",
                            hint: "",
                            readOnly: true,
                            borderColor: Colors.black,
                            activeBorderColor: Colors.black,
                            labelColor: Colors.black,
                            onTap:()=> _pickDate(initialDate:state.from!,onPicked:cubit.selectFrom),
                            controller: TextEditingController()..text=state.from!.formattedDateFr,
                          )
                      ),
                      const Icon(Icons.swap_horiz,color: Colors.grey,),
                      Expanded(
                          child: MyFormField(
                            label: "",
                            hint: "",
                            readOnly: true,
                            borderColor: Colors.black,
                            activeBorderColor: Colors.black,
                            labelColor: Colors.black,
                            onTap:()=> _pickDate(initialDate:state.to!,onPicked:cubit.selectTo),
                            controller: TextEditingController()..text=state.to!.formattedDateFr,
                          )
                      ),
                      const SizedBox(width: 3),
                      MyCustomButton(
                        name: "",
                        icon: Icons.search,
                        fontSize: 14,
                        color: AppColors.primaryColor,
                        width: 80,
                        onClick: cubit.fetchData,
                        isLoading: state.fetchStatus==AppStatus.loading,
                      )
                    ],
                  ),



                  if(state.fetchStatus==AppStatus.success)...[
                    const SizedBox(height: 15,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Résumé",
                        style: GoogleFonts.aBeeZee(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.rapportResponse?.total??"-"}",
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Text(
                            "Total des repas consommés",
                            style: GoogleFonts.aBeeZee(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          const SizedBox(height: 25,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Détails",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          ...List.from(
                              state.rapportResponse?.personnel?.map(
                                      (e) => ListTile(
                                    onTap: ()=>onPersonelClick(e),
                                    leading:Container(
                                        width: 60,
                                        height: 60,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        child:e.profile!=null
                                            ?Image.network(e.fullImageUrl)
                                            :Image.asset(AppImages.img_profile)
                                    ),
                                    title: Text(
                                      "${e.fullName}",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    subtitle:Text(
                                      "Nombre de repas consommés: ${e.nbRepas}",
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                  )
                              )
                                  ??[])
                        ],
                      ),
                    )
                  ]
                  else if(state.fetchStatus==AppStatus.error)...[
                    OfflineErrodWidget(isOffline: state.isOffline??false,action: fetchData,error: state.error,)
                  ]
                ],
              ),
            );

          },
        ));
  }

  Future<void> _pickDate({
    required DateTime initialDate,
    required ValueChanged<DateTime> onPicked,
  }) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) onPicked(picked);
  }

  void fetchData() {
    BlocProvider.of<PersonelCubit>(context).fetchData();
  }

  void onSelectFrom() async {
    DateTime? date = await showDatePicker(
        context: context,
        fieldLabelText: "",
        helpText: "",
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(const Duration(days: 1)));
    if (date != null) {
      BlocProvider.of<PersonelCubit>(context).selectFrom(date);
    }
  }

  void onSelectTo() async {
    DateTime? date = await showDatePicker(
        context: context,
        fieldLabelText: "",
        helpText: "",
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(const Duration(days: 1)));
    if (date != null) {
      BlocProvider.of<PersonelCubit>(context).selectTo(date);
    }
  }

  void onPersonelClick(Personel p) {
    PersonelState personelState=BlocProvider.of<PersonelCubit>(context).state;
    String url=Routes.historique.replaceAll(":id", p.id.toString());
    url="${url}?from=${personelState.from!.formattedDateEn}&to=${personelState.to!.formattedDateEn}";
    GoRouter.of(context).push(url);
  }

  void onLogout() async{
    var result=await showDialogueQuestion(context, "Voulez-vous vous déconnecter ?","Oui","Non");
    if(result!=null && result){
      logout(context);
    }
  }
}
