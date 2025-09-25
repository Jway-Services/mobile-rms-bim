import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';


class LoadingWidget extends StatelessWidget {
  double width;
  LoadingWidget({this.width=370}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(AppImages.app_logo,width: width,),
        LoadingAnimationWidget.flickr(leftDotColor: AppColors.primaryColor, rightDotColor: AppColors.secondaryColor, size: 40)
      ],
    );
  }
}
