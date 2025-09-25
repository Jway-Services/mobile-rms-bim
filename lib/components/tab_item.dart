import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';





class TabItem extends StatelessWidget {
  String? icon;
  String? name;
  Color? color;

   TabItem({this.icon,this.color=AppColors.primaryColor,this.name}) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(icon!=null)
        ImageIcon(AssetImage(icon!), color:color,),
        SizedBox(width: 4,),
        if(name!=null)
        Text(name!, style: GoogleFonts.aBeeZee(color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16),)
      ],
    );
  }
}


