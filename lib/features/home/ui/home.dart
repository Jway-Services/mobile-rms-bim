import 'package:bim/components/custom_button.dart';
import 'package:bim/components/error_offline_widget.dart';
import 'package:bim/components/form_field.dart';
import 'package:bim/core/constants/app_colors.dart';
import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:bim/features/home/cubit/home_cubit.dart';
import 'package:bim/features/home/ui/components/column_chart.dart';
import 'package:bim/features/home/ui/components/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../core/utils/logout.dart';
import '../../../core/utils/show_dialogue_question.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  static Widget page() {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: const Home(),
    );
  }

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateFormat _formatter = DateFormat('yyyy-MM-dd');


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
        title:  Text('Accueil',style: GoogleFonts.aBeeZee(color:AppColors.primaryColor),),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        actions: [
          IconButton(onPressed: onLogout, icon: const Icon(Icons.logout,color: AppColors.primaryColor,))
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// Date selection
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
                          onTap:()=> _pickDate(initialDate:state.from,onPicked:cubit.selectFrom),
                          controller: TextEditingController()..text=state.from.formattedDateFr,
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
                          onTap:()=> _pickDate(initialDate:state.to,onPicked:cubit.selectTo),
                          controller: TextEditingController()..text=state.to.formattedDateFr,
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
                      isLoading: state.fetchDataStatus==AppStatus.loading,
                    )
                  ],
                ),

                const SizedBox(height: 20),

                /// Data charts
                if(state.fetchDataStatus==AppStatus.success)...[
                  Expanded(
                    child: state.dashboardData == null
                        ? const Center(child: Text('No data yet'))
                        : ListView(
                      children: [
                        //_buildChartSection('Departement', state.dashboardData!.departement),
                        PieChartWidget(data: state.dashboardData!.departement, title: "Departement"),
                        const SizedBox(height: 8,),
                        ColumnChart(data: state.dashboardData!.personnel, title: "Personnel"),
                        const SizedBox(height: 8,),
                        PieChartWidget(title: 'Region',data:  state.dashboardData!.region),
                        const SizedBox(height: 8,),
                        ColumnChart(data: state.dashboardData!.hour, title: "Nombre de repas consommés par heure")
                      ],
                    ),
                  ),
                ]else if(state.fetchDataStatus==AppStatus.error)...[
                  OfflineErrodWidget(isOffline: state.isOffline??false,action: fetchData,error: state.error,)
                ]
              ],
            ),
          );
        },

      ),
    );
  }

  void onLogout() async{
    var result=await showDialogueQuestion(context, "Voulez-vous vous déconnecter ?","Oui","Non");
    if(result!=null && result){
      logout(context);
    }
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
    BlocProvider.of<HomeCubit>(context).fetchData();
  }
}
