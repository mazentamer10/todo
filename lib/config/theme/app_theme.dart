import 'package:flutter/material.dart';
import 'package:todo_app/core/utils/app_style.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class AppTheme{
  static ThemeData light = ThemeData(
    useMaterial3: false,
      primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSeed(seedColor:ColorsManger.blue,
    primary: ColorsManger.blue,
    onPrimary: ColorsManger.white),

    appBarTheme:  AppBarTheme(backgroundColor: ColorsManger.blue,
    titleTextStyle: ApplightStyles.appBarTextStyle ),
      scaffoldBackgroundColor: ColorsManger.scaffoldBg,
    bottomAppBarTheme: const BottomAppBarTheme(color: ColorsManger.white, shape: CircularNotchedRectangle(),),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManger.blue,
      unselectedItemColor: ColorsManger.grey,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManger.blue,
        iconSize: 33,
        shape: StadiumBorder(
            side: BorderSide(color: ColorsManger.white, width: 4))),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            )),
        backgroundColor: ColorsManger.white, elevation: 18,)
  );
}