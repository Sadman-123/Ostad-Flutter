import 'package:flutter/material.dart';
void main()
{
  runApp(Main());
}
class Main extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}
class App extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bag",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.amber
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              color: Colors.pink,
            )
          ],
        ),
      ),
    );
  }
}