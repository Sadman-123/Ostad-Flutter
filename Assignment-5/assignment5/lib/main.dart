import 'package:assignment5/screens/home.dart';
import 'package:assignment5/screens/home_details.dart';
import 'package:flutter/material.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.of(context).size.width;
    var mdh=MediaQuery.of(context).size.height;
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder()
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontSize: mdw*0.079,color: Colors.black,fontWeight: FontWeight.w800)
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.black,
          backgroundColor: Colors.blueAccent.shade100
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}