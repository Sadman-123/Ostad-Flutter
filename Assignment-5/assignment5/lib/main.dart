import 'package:assignment5/screens/home.dart';
import 'package:flutter/cupertino.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: Home() ,
    );
  }
}