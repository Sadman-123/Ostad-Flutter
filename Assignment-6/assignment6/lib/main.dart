import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/initial_screens/forgot_password/emailpage.dart';
import 'package:task_manager/initial_screens/forgot_password/otppage.dart';
import 'package:task_manager/initial_screens/forgot_password/passwordpage.dart';
import 'package:task_manager/initial_screens/login.dart';
import 'package:task_manager/initial_screens/registration.dart';
import 'style/style.dart';
import 'initial_screens/splash.dart';
import 'task_screens/task_home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(TaskController());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  runApp(Main(hasToken: token != null));
}
class Main extends StatelessWidget {
  final bool hasToken;
  Main({required this.hasToken});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: input_theme(),
        navigationBarTheme: bottom_navbar_theme(),
        floatingActionButtonTheme: floating_btn_theme(),
      ),
      initialRoute: hasToken? '/home':'/splash',
      routes: {
        '/splash':(context)=>Splash(),
        '/login':(context)=>Login(),
        '/register':(context)=>Registration(),
        '/home':(context)=>TaskHome(),
        '/EmailVerify':(context)=>Emailpage(),
        '/OtpVerify':(context)=>Otppage(),
        '/NewPassword':(context)=>Passwordpage()
      },
    );
  }
}
