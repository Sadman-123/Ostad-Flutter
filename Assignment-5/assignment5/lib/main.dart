import 'package:assignment5/screens/home.dart';
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
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontSize: mdw*0.079,color: Colors.black,fontWeight: FontWeight.w800)
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Home() ,
    );
  }
}