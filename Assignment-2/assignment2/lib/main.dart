import 'package:flutter/material.dart';
void main() => runApp(Main());
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Greeting(),
    );
  }
}
class Greeting extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Greeting App"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Hello, World!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 30),),
            SizedBox(height: 10,),
            Text("Welcome to Flutter!",style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            Image.network("https://cdn.iconscout.com/icon/free/png-256/free-flutter-3628777-3030139.png?f=webp",width: 100,height: 100,),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.black)
              ),
                onPressed: (){
              final st=SnackBar(
                backgroundColor: Colors.lightBlue,
                content: Text("Button Pressed!"),
              );
              ScaffoldMessenger.of(context).showSnackBar(st);
            }, child: Text("Press Me"))
          ],
        ),
      ),
    );
  }
}