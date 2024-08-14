import 'package:flutter/material.dart';
void main(){
  runApp(Main());
}
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MyTextPrac(),
    );
  }
}
class MyTextPrac extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Styling App"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter Text Styling",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Experiment with text styles",style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              final stkbr=SnackBar(content: Text("You clicked the button!"));
              ScaffoldMessenger.of(context).showSnackBar(stkbr);
            }, child: Text("Click Me")),
            RichText(text: TextSpan(
                text: 'Welcome to ',
                style: TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Flutter!',
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}