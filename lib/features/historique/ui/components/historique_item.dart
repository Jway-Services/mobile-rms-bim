
import 'package:bim/core/extensions/extension_on_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../components/custom_button.dart';
import '../../../../components/shimming_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../models/historique.dart';

class HistoriqueItem extends StatelessWidget {
  Historique? historique;
  bool? isLoading;
  void Function(Historique)? onDelete;

  HistoriqueItem({this.isLoading, this.onDelete,this.historique});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        clipBehavior: Clip.hardEdge,
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            (isLoading ?? false)
                ? ShimmingWidget(
                    width: 120,
                    height: 10,
                    borderRadius: 10,
                  )
                : Text(
                    "${historique?.date?.formattedDateFr} à ${historique?.date?.formattedTime}",
                    style: GoogleFonts.poppins(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
            const SizedBox(
              height: 18,
            ),
            item("nom complet :", historique?.user?.fullName),
            item("Module :", historique?.module),
            const SizedBox(
              height: 10,
            ),
            if (!(isLoading ?? false))
              Text(historique?.action ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),

            SizedBox(height: 15,),

            if (!(isLoading ?? false))
            MyCustomButton(name: "Supprimer",
              icon: Icons.delete,
              color: Colors.red,
              width: 160,
              height: 44,
              borderRadius: 6,
              onClick:()=>onDelete?.call(historique!),
              iconColor: Colors.white,)
          ],
        ));
  }

  Widget item(String name, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name ?? "",
            style: GoogleFonts.poppins(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 17),
          ),
          (isLoading ?? false)
              ? ShimmingWidget(
                  width: 120,
                  height: 10,
                  borderRadius: 10,
                )
              : (value is String)
                  ? Expanded(
                      child: Text(
                        value,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 15),
                      ),
                    )
                  : value
        ],
      ),
    );
  }



}
