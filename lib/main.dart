import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/homescreen.dart';


void main(){
  runApp(const Attendance());

  print("This is second Commit");
}

class Attendance extends StatelessWidget {
  const Attendance({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:ThemeData.light().copyWith(
        appBarTheme:const AppBarTheme(
          color:Colors.white70
        )
      ),
      home: HomeScreen(),
    );
  }
}
