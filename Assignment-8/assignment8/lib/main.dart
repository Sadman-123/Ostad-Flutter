import 'package:assignment8/screens/home.dart';
import 'package:flutter/material.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      initialRoute: '/home',
      routes: {
        '/home':(context)=>MapScreen()
      },
    );
  }
}