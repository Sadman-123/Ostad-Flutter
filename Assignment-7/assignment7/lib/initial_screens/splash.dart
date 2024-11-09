import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'login.dart';
class Splash extends StatefulWidget{
  @override
  State<Splash> createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    GOTONEXT();
  }
  Future<void>GOTONEXT()async{
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
  }
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SvgPicture.asset("assets/background.svg",fit: BoxFit.fitHeight,),
            Container(
              child: Center(
                child: SvgPicture.asset("assets/logo_rabbil.svg",width: mdw*0.43,),
              ),
            ),
          ],
        ),
      )
    );
  }
}