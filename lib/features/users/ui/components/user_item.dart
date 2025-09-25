import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/shimming_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../models/privilege.dart';
import '../../../../models/user.dart';






class UserItem extends StatelessWidget {
  User? user;
  bool? isLoading;

  UserItem({this.user,this.isLoading});

  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.sizeOf(context).width;
    return Container(
      width: width,
      padding:const EdgeInsets.symmetric(horizontal: 14),
      clipBehavior: Clip.hardEdge,
      constraints: BoxConstraints(maxWidth: 400),
      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20)),
      child: ExpansionTile(
        iconColor: AppColors.secondaryColor,
        collapsedIconColor: AppColors.secondaryColor,
        title:(isLoading??false)
            ?ShimmingWidget(width: 110, height: 10,borderRadius: 8,)
            : Text(
          user?.email ?? "",
          style: GoogleFonts.acme(
              color: AppColors.primaryColor,fontSize:18, fontWeight: FontWeight.bold),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children:user?.onlyAuthorisedPriv.map(
                      (priv) => privilege(priv)
              ).toList() ?? [] ,
            ),
          ),
          item("ID :", user?.id.toString()),
          item("Nom :", user?.lastName),
          item("Prénom :", user?.firstName),
          item("Role :",
              Container(
                width: 110,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: user?.admin=="1"?Colors.red:Colors.blue
                ),
                child: Text(
                  user?.admin=="1"?"ADMIN":"USER",
                  style: GoogleFonts.acme(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget privilege(Privilege privilegeEntity){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(privilegeEntity.title!,style: GoogleFonts.acme(color:Colors.white,fontWeight:FontWeight.bold),),
    );
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
              ? Text(
            value,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          )
              : value
        ],
      ),
    );
  }
}
