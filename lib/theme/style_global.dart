
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themas {
  static double defaultMargin = 20.0;
  static double defaultBorder = 20.0;
  static Color kWhiteColor = const Color(0xffFFFFFF);
  static Color kWhiteColord = const Color.fromARGB(255, 126, 122, 122);
  static Color kBackgroundColor = const Color(0xff1A1A1A);
  static Color kBackgroundColorButton = const Color(0xff111B21);
  static Color kGreyColor = const Color(0xff202C33);
  static Color kPrimaryColor = const Color(0xffFEBE02);
  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: kWhiteColor,
  );
  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: kBackgroundColor,
  );
  static TextStyle yellowTextStyle = GoogleFonts.poppins(
    color: kPrimaryColor,
  );
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight extraBold = FontWeight.w800;
  static FontWeight black = FontWeight.w900;
}