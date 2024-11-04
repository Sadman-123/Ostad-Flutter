import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/components/have_act_msg.dart';
import 'package:task_manager/style/style.dart';
import '../../components/mybutton.dart';
class Otppage extends StatefulWidget {
  @override
  State<Otppage> createState() => _OtppageState();
}
class _OtppageState extends State<Otppage> {
  String recovery_otp = "";
  String recovery_email = "";
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?; // Cast as Map
    recovery_email = args?['email'] ?? "";
  }
  void get_otp(String pin) {
    setState(() {
      recovery_otp = pin;
    });
  }
  Future<void> check_otp() async {
    try {
      var url = Uri.parse(
        "http://35.73.30.144:2005/api/v1/RecoverVerifyOtp/$recovery_email/$recovery_otp",
      );
      var res = await http.get(url, headers: {'Content-Type': 'application/json'});
      if (res.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP Matched",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Color(0xFF20be73),
          textColor: Colors.white,
        );
        Navigator.pushNamed(context, '/NewPassword');
      } else {
        Fluttertoast.showToast(
          msg: "Something Went Wrong: ${res.body}",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Internal Error",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.sizeOf(context).width;
    var mdh = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            background_img('assets/background.svg'),
            Center(
              child: Container(
                height: mdh * 0.45,
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: mdw * 0.79,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("PIN Verification", style: H1text(mdw)),
                                Text(
                                  "A 6 digit verification pin has been sent to your email address",
                                  style: H4text(mdw),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: mdh * 0.035),
                          Wrap(
                            spacing: 8.0,
                            children: [
                              Pinput(
                                length: 6,
                                keyboardType: TextInputType.number,
                                pinAnimationType: PinAnimationType.scale,
                                defaultPinTheme: pin_code_theme(),
                                onChanged: get_otp,
                              ),
                            ],
                          ),
                          SizedBox(height: mdh * 0.024),
                          Mybutton(
                            onpressed: check_otp,
                            something: Center(
                              child: Text("Verify", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: mdh * 0.04),
                    HaveActMsg(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
