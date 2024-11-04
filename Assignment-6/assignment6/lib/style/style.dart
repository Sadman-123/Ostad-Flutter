import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
//Task Cards Label Colors
const New_Task_Label_Color=Color(0xFF14c4ec);
const Progress_Task_Label_Color=Color(0xFFcb0d9e);
const Cancelled_Task_Label_Color=Color(0xFFf05057);
const Completed_Task_Label_Color=Color(0xFF21be72);
//Universal color related
const MythemeColor=Color(0xFF20be73);
//Universal Header and Subtitle related
TextStyle H1text(var mdw)
{
  return  TextStyle(
      fontSize: mdw*0.08,
      fontWeight: FontWeight.w800,
      color: Color(0xFF1A1C20),
      fontFamily: "apple"
  );
}
TextStyle H4text(var mdw)
{
  return  TextStyle(
    fontFamily: "apple",
      color: Colors.black54,
  );
}

//sum box related
TextStyle Sum_Tile_Num(var mdw){
  return TextStyle(
      fontSize: mdw*0.06,
      fontFamily: "apple",
      fontWeight: FontWeight.bold,
  );
}
TextStyle Sum_Tile_Title(var mdw){
  return TextStyle(
      fontSize: mdw*0.04,
      fontFamily: "apple"
  );
}
//appbar related
TextStyle Appbar_Username(var mdw)
{
  return TextStyle(
      fontSize: mdw * 0.05,
      fontWeight: FontWeight.bold,
      color: Color(0xFFecf8f8),
      fontFamily: "apple"
  );
}
TextStyle Appbar_Email(var mdw)
{
  return TextStyle(
      fontSize: mdw * 0.04,
      fontWeight: FontWeight.bold,
      color: Color(0xFFecf8f8),
      fontFamily: "apple"
  );
}
//Task card related
TextStyle Task_Card_Title(var mdw){
  return TextStyle(
      fontSize: mdw*0.07,
      fontWeight: FontWeight.bold,
      fontFamily: "apple",
    overflow: TextOverflow.ellipsis
  );
}
TextStyle Task_Card_Content(var mdw){
  return TextStyle(
      fontSize: mdw*0.05,
      fontFamily: "apple",
      overflow: TextOverflow.ellipsis
  );
}
TextStyle Task_Card_Date(var mdw){
  return TextStyle(
      fontSize: mdw*0.048,
      fontWeight: FontWeight.w500,
      fontFamily: "apple"
  );
}
//Background SVG related
Positioned background_img(String img){
  return Positioned.fill(
    child: SvgPicture.asset(
      "$img",
      fit: BoxFit.cover,
    ),
  );
}
//Themes
InputDecorationTheme input_theme(){
  return InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    prefixIconColor: Colors.black54,
    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 2.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
        width: 2.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.blueAccent,
        width: 2.5,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 2.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 2.5,
      ),
    ),
    hintStyle: TextStyle(
      color: Colors.grey.shade700,
      fontSize: 16,
    ),
    labelStyle: TextStyle(
      color: Colors.blueAccent,
      fontSize: 16,
    ),
  );
}
NavigationBarThemeData bottom_navbar_theme()
{
  return NavigationBarThemeData(
    indicatorColor: Color(0xFFB6FFA1),
    labelTextStyle: WidgetStatePropertyAll(TextStyle(fontFamily: "apple"),)
  );
}
FloatingActionButtonThemeData floating_btn_theme()
{
  return FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF20be73),
  );
}
PinTheme pin_code_theme()
{
  return PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color(0xFFb7efc5),
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}