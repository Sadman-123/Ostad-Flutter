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
      // theme: CupertinoThemeData(
      //   textTheme: CupertinoTextThemeData(
      //     textStyle: TextStyle(
      //       fontFamily: "apple",
      //       color: CupertinoColors.black
      //     )
      //   )
      // ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}