import 'package:assignment5/screens/blog_home.dart';
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
      home: Home(),
    );
  }
}