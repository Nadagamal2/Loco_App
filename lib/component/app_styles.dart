import 'dart:ui';
import 'package:flutter/material.dart';

Color primary = const Color(0xffffffff);

class Styles {
  static Color defualtColor=Color(0xffFF7B2C);
  static Color defualtColor3=Color(0xff129515);
  static Color defualtColor4=Colors.grey.shade500;
  static Color defualtColor6=Color(0xffF7F7F7);

  static Color defualtColor2=Color(0xffBCBCBB);
   static Color ScafoldColor = primary;
  static Color ScafoldColor2 =  Color(0xffF5F5F5);
    static Color defaultColor11=Color(0xffE0DBDA);
   static Color defaultColor5=Colors.white;
  static Color defaultColor7=Colors.grey.shade900;
  static Color defaultColor10=Colors.black;
  static Color defaultColor8= Colors.grey.shade400;
  static Color defaultColor9= Colors.grey.shade300;

  static TextStyle buttomStyle = TextStyle(
    color: Styles.ScafoldColor,
     fontSize: 18,
  );
  static TextStyle headLineGray1 = TextStyle(
    color: Colors.grey.shade500,
    fontSize: 12.5,
  );
  static TextStyle headLine1 = TextStyle(
    color: Color(0xff22D27F),
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static TextStyle headLine2 = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );
  static TextStyle headLine3 = TextStyle(
    fontSize: 13.0,
    color: Colors.black54,
  );
  static TextStyle textButtom = TextStyle(
    fontSize: 12.2,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    decoration: TextDecoration.underline,
  );



  static TextStyle lable_Hint =  TextStyle(color: Color(0xffB6B6B6), fontWeight: FontWeight.w600);
}
