import 'dart:ui';

import 'package:bim/core/constants/app_strings.dart';
import 'package:bim/core/constants/enums/app_status.dart';
import 'package:bim/core/utils/show_toast.dart';
import 'package:bim/features/auth/login/bloc/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';


import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../../../../core/constants/app_images.dart';
import '../../../../../../routes.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/form_field.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  static Widget page(){
    return BlocProvider(
      create: (ctx)=>LoginBloc(),
      child: LoginScreen(),
    );
  }


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController=TextEditingController();
    passwordController=TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.sizeOf(context).width;
    double height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                BlocListener<LoginBloc,LoginState>(
                    listener: listener,
                  child: SizedBox(),
                ),
                Image.asset(AppImages.app_logo,height: 250,),
                /*Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextAnimator(
                        "Connexion",
                        style: GoogleFonts.aBeeZee(color:Colors.black,fontSize:35,fontWeight:FontWeight.bold),
                        atRestEffect: WidgetRestingEffects(duration: const Duration(seconds: 2),style: WidgetRestingEffectStyle.none),
                      ),
                      TextAnimator(
                        "Welcome Back! Please log in to continue.",
                        style: GoogleFonts.aBeeZee(color:Colors.black,fontSize:20,fontWeight:FontWeight.normal),
                        atRestEffect: WidgetRestingEffects(duration: const Duration(seconds: 2),style: WidgetRestingEffectStyle.none),
                      ),
                    ],
                  ),
                ),*/
                const SizedBox(height: 30,),
                Container(
                  width: width,
                  constraints: const BoxConstraints(
                      maxWidth: 400
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
                  decoration:BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                      //boxShadow: const [BoxShadow(color: Colors.grey,offset: Offset(3,3),blurRadius: 20)],
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child:Column(
                    children: [
                      TextAnimator(
                        "Connexion",
                        style: GoogleFonts.aBeeZee(color:Colors.black,fontSize:35,fontWeight:FontWeight.bold),
                        atRestEffect: WidgetRestingEffects(duration: const Duration(seconds: 2),style: WidgetRestingEffectStyle.none),
                      ),
                      const SizedBox(height: 10,),
                      MyFormField(
                        label: "Nom d'utilisateur",
                        hint: "Entrez  votre nom d'utilisateur",
                        borderColor: Colors.transparent,
                        activeBorderColor: Colors.transparent,
                        controller: emailController,
                        labelColor: Colors.black,
                          hintColor: const Color(0xff4F7096),
                        fillColor: const Color(0xffE8EDF2),
                      ),
                      const SizedBox(height: 20,),
                      MyFormField(
                        label: "Mot de passe",
                        hint: 'Entrez  votre mot de passe',
                        borderColor: Colors.transparent,
                        activeBorderColor: Colors.transparent,
                        labelColor: Colors.black,
                        hintColor: const Color(0xff4F7096),

                        fillColor: const Color(0xffE8EDF2),
                        openEyeIcon:  const Icon(Icons.remove_red_eye_outlined,color: Colors.black,),
                        closeEyeIcon: const Icon(FontAwesomeIcons.eyeSlash,color: Colors.black,),
                        isPassWord: true,
                        controller: passwordController,
                      ),
                      /* Align(
                     alignment: Alignment.centerRight,
                     child:  MyTextButton(parts: const ["I forget password"], colors: const [Colors.black],onclick: forgetPassClick,),
                   ),*/
                      const SizedBox(height: 20,),
                      BlocBuilder<LoginBloc,LoginState>(
                          builder: (ctx,state){
                            return MyCustomButton(
                              name: "Connexion",
                              borderRadius: 30,
                              textColor: Colors.black,
                              color: const Color(0xffB2C9E5),
                              isLoading:state.loginStatus==AppStatus.loading ,
                              onClick: onLoginClick,
                            );
                          }
                      )
                      //MyTextButton(parts: const ["don't have an account?"," Register"], colors: const [Colors.black,AppColors.primaryColor],onclick: registerCLick,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    GoRouter.of(context).replace(Routes.register);
  }

  void forgetPassClick() {
    GoRouter.of(context).replace(Routes.resetPassword);
  }

  void registerCLick() {
    GoRouter.of(context).replace(Routes.register);
  }

  void listener(BuildContext context, LoginState state) {
    if(state.loginStatus==AppStatus.success){
      showToast("Success", context,second: 2,whenComplete: (){

        while(GoRouter.of(context).canPop()){
          GoRouter.of(context).pop();
      }
      GoRouter.of(context).replace(Routes.rapport);

      });
    }else if(state.loginStatus==AppStatus.error){
      if(!(state.isAuth??true)){
        showToast(
            "",
            context,
            description: "Nom d'utilisateur ou mot de passe incorrect.",
            type: ToastificationType.error
        );
        return;
      }else if(state.isOffline??false){
        showToast(
            "",
            context,
            description: AppStrings.checkConnectivity,
            type: ToastificationType.warning
        );
        return;
      }
      showToast(
          "Error",
          context,
          type: ToastificationType.error
      );
    }
  }

  void onLoginClick() {
    BlocProvider.of<LoginBloc>(context).add(Login(emailController.text, passwordController.text));
  }
}
