
import 'package:flutter/material.dart';



import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';


class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({Key? key, required this.navigationShell}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _onTabChanged(int index) {

    widget.navigationShell.goBranch(index,initialLocation: index==widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 7),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey,width: 0.6))
        ),
        child: GNav(
          selectedIndex: widget.navigationShell.currentIndex,
          backgroundColor: Colors.white,
          color: AppColors.primaryColor,
          activeColor: Colors.white,
          tabBackgroundColor: const Color(0xFF1A237E), // Deep Indigo
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          gap: 10,
          iconSize: 24,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 300),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          tabMargin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          textStyle:  GoogleFonts.aBeeZee(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),


          haptic: true,
          rippleColor: Colors.grey.shade200,
          hoverColor: Colors.grey.shade100,

          onTabChange: _onTabChanged,
          tabs:  [
            GButton(
              leading:ImageIcon(
                const AssetImage(AppImages.ic_home),
                color: widget.navigationShell.currentIndex==0?Colors.white:AppColors.primaryColor,
              ),
              icon: Icons.circle,
              iconColor: Colors.transparent ,
              text: 'Accueil',
              backgroundColor: AppColors.primaryColor,
            ),
            GButton(
              leading:ImageIcon(
                const AssetImage(AppImages.ic_rapport),
                color: widget.navigationShell.currentIndex==1?Colors.white:AppColors.primaryColor,
              ),
              icon: Icons.circle,
              iconColor: Colors.transparent ,
              text: 'Rapports',
              backgroundColor: AppColors.primaryColor,
            ),

            GButton(
              leading:ImageIcon(
                const AssetImage(AppImages.ic_param),
                color: widget.navigationShell.currentIndex==2?Colors.white:AppColors.primaryColor,
              ),
              icon: Icons.circle,
              iconColor: Colors.transparent ,
              text: 'Administration',
              backgroundColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
