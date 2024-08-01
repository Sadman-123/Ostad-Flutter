import 'package:flutter/material.dart';
void main() => runApp(Main());
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.lightBlue
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontSize: 26,color: Colors.white)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          )
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))
          ),
        )
      ),
      home: Home(),
    );
  }
}
class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 130,),
            Text("Welcome to the Home Screen!",style: TextStyle(fontSize: 24),),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Details()));
            }, child: Text("Go to Detail Screen")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));
            }, child: Text("Go to Settings"))
          ],
        ),
      )
    );
  }
}
class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting Screens",),
        backgroundColor: Theme.of(context).primaryColor,
      ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 130,),
              Text("Settings",style: TextStyle(fontSize: 30),),
              SizedBox(height: 10,),
              Text("Adjust your preferences here",style: TextStyle(fontSize: 18),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                final snk=SnackBar(
                  content: Text("Saved."),
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(10),
                );
                ScaffoldMessenger.of(context).showSnackBar(snk);
              }, child: Text("Save Settings")),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              }, child: Text("Back to Home"))
            ],
          ),
        )
    );
  }
}
class Details extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text("This is the Detail Screen!",style: TextStyle(fontSize: 24),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        },
        child: Icon(Icons.arrow_back_sharp,color: Colors.black,),
      ),
    );
  }
}
