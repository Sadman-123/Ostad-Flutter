import 'package:flutter/material.dart';
Widget Mobile_View()
{
  return Scaffold(
   appBar: AppBar(),
    drawer: Drawer(
      child: ListView(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.blue,
          )
        ],
      ),
    ),
  );
}