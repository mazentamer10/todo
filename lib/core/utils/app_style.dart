
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/utils/colors_manager.dart';

class ApplightStyles{
  static TextStyle? appBarTextStyle = GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color:ColorsManger.white);
  static TextStyle? bottomSheetTitle = GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700,color:ColorsManger.blackAccent);
  static TextStyle? hintStyle = GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManger.grey);
  static TextStyle? dateLabel = GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400, color: ColorsManger.blackAccent);
  static TextStyle? dateStyle = GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManger.grey);
  static TextStyle? tasksTitle = GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManger.blue);
  static TextStyle? taskDesc = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.normal, color: ColorsManger.blackAccent);
  static TextStyle? calenderSelectedItem = GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, color: ColorsManger.blue);
  static TextStyle? calenderUnSelectedItem = GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w400, color: ColorsManger.blackAccent);
  static TextStyle? title = GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: ColorsManger.white);
  static TextStyle? hint = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w300, color: ColorsManger.black.withOpacity(0.7));
  static TextStyle? buttonTitle = GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue.shade900);
}