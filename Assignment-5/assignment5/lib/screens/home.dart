import 'package:assignment5/diy_widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Home extends StatefulWidget
{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Blogs"),
     ),
     body: BlogCard(),
     floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(FontAwesomeIcons.pen),),
   );
  }
}