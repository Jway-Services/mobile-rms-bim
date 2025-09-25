import 'package:bim/components/circle_image.dart';
import 'package:bim/components/error_offline_widget.dart';
import 'package:bim/components/loading_widget.dart';
import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:bim/features/personel_historiques/bloc/personel_historique_cubit.dart';
import 'package:bim/features/rapport/cubit/personel_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';

class PersonelHistorique extends StatefulWidget {
  PersonelHistorique({Key? key}) : super(key: key);

  static Widget page(int personel, String from, String to) {
    return BlocProvider<PersonelHistoriqueCubit>(
      create: (context) => PersonelHistoriqueCubit(personel, from, to),
      child: PersonelHistorique(),
    );
  }

  @override
  State<PersonelHistorique> createState() => _PersonelHistoriqueState();
}

class _PersonelHistoriqueState extends State<PersonelHistorique> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primaryColor,
        title:  Text('Repas',style: GoogleFonts.aBeeZee(color:AppColors.primaryColor),),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        // Add elevation to create shadow
        shadowColor: Colors.grey.withOpacity(0.3),
      ),
      body: BlocBuilder<PersonelHistoriqueCubit, PersonelHistoriqueState>(
        builder: (context, state) {
         if(state.fetchData==AppStatus.loading){
           return Center(child: LoadingWidget(width: 200,));
         }else if(state.fetchData==AppStatus.error){
           return OfflineErrodWidget(isOffline: state.isOffline??false,error: state.error,action: fetchData,);
         }else if(state.fetchData==AppStatus.success){
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               // Fixed header section with background
               Container(
                 width: double.infinity,
                 color: Colors.white,
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(height: 20),
                     Center(
                       child: Container(
                         width: 60,
                         height: 60,
                         clipBehavior: Clip.hardEdge,
                         decoration: const BoxDecoration(
                             shape: BoxShape.circle
                         ),
                         child:state.personel?.profile!=null
                             ?Image.network(state.personel!.fullImageUrl)
                             :Image.asset(AppImages.img_profile)
                       ),
                     ),
                     const SizedBox(height: 20),
                     Center(
                       child: Text(
                         "${state.personel?.fullName}",
                         style: GoogleFonts.aBeeZee(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                         ),
                       ),
                     ),
                     const SizedBox(height: 8),
                     Center(
                       child: Text(
                         "Total des repas consommés: ${state.personel?.nbRepas}",
                         style: GoogleFonts.aBeeZee(
                           color: Colors.grey,
                           fontWeight: FontWeight.bold,
                           fontSize: 18,
                         ),
                       ),
                     ),
                     const SizedBox(height: 25),
                     Text(
                       "Liste des Repas Consommés:",
                       style: GoogleFonts.aBeeZee(
                         color: Colors.black,
                         fontSize: 17,
                       ),
                     ),
                     const SizedBox(height: 10),
                   ],
                 ),
               ),

               // Scrollable list section
               Expanded(
                 child: Container(
                   color: Colors.white,
                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                   child: ListView.builder(
                     padding: const EdgeInsets.only(bottom: 20),
                     itemCount: state.personel?.historiques?.length ?? 0,
                     itemBuilder: (context, index) {
                       final item = state.personel!.historiques![index];
                       return Container(
                         margin: EdgeInsets.symmetric(horizontal: 6,vertical: 7),
                         decoration: BoxDecoration(
                           color: Colors.grey[100],
                           borderRadius: BorderRadius.circular(10)
                         ),
                         child: ListTile(
                           title: Text(
                             "${item.formattedDateFr}-${item.formattedTime}",
                             style: GoogleFonts.aBeeZee(
                               color: Colors.black,
                               fontSize: 14,
                             ),
                           ),
                         ),
                       );
                     },
                   ),
                 ),
               ),
             ],
           );
         }
         return SizedBox();
        },
      ),
    );
  }

  void fetchData() {
    BlocProvider.of<PersonelHistoriqueCubit>(context).fetchData();
  }
}

