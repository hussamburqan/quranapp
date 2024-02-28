import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key,required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20,top: 10),
      child: GNav(

        onTabChange: (value) => {
          onTabChange!(value),
          print(value)
        },
        color: Colors.green ,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.green,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 20,

        tabs: const[
          GButton(icon: Icons.home, text: 'القائمه الرئيسية' ,),
          GButton(icon: Icons.leaderboard, text: ' المتصدرين ' ,),
          GButton(icon: Icons.ac_unit, text: ' فعاليات ' ,),
          GButton(icon: Icons.account_circle, text: ' الملف الشخصي ' ,)
      ],
      ),
    );
  }
}
