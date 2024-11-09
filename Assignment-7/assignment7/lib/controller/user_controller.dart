import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:task_manager/components/diy_toast.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/initial_screens/forgot_password/otppage.dart';
import 'package:task_manager/initial_screens/forgot_password/passwordpage.dart';
import 'package:task_manager/initial_screens/login.dart';
import 'dart:convert';
import 'package:task_manager/task_screens/task_home.dart';
class UserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getProfileDetails().then((_) {
      loadImageFromPrefs();
    });
  }
  @override
  void onClose() {
    email.dispose();
    first_name.dispose();
    last_name.dispose();
    mobile.dispose();
    password.dispose();
    recovery_email.dispose();
    recovery_pass.dispose();
    recovery_pass_confirm.dispose();
    super.onClose();
  }
  RxString Appbar_Name = "".obs;
  RxString Appbar_Email = "".obs;
  RxMap<String, String> userInfo = <String, String>{}.obs;
  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController recovery_email=TextEditingController();
  RxString recovery_otp="".obs;
  TextEditingController recovery_pass=TextEditingController();
  TextEditingController recovery_pass_confirm=TextEditingController();
  RxString picurl = "".obs;
  Rx<File> appbarImage = File("").obs;
  void get_otp(pin){
    recovery_otp.value=pin;
  }
  Future<void> registration(BuildContext context, TextEditingController email,
      TextEditingController first_name, TextEditingController last_name,
      TextEditingController password, TextEditingController mobile) async {
    if (email.text.isEmpty || first_name.text.isEmpty ||
        last_name.text.isEmpty || password.text.isEmpty ||
        mobile.text.isEmpty) {
      JossToast(msg: "Fill Every Box",isGood: false);
      return;
    } else {
      var dat = {
        "email": email.text,
        "firstName": first_name.text,
        "lastName": last_name.text,
        "mobile": mobile.text,
        "password": password.text
      };
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/Registration");
      var res = await http.post(
          url, headers: {'Content-Type': 'application/json'},
          body: json.encode(dat));
      if (res.statusCode == 200) {
        JossToast(isGood: true,msg: "Account Created Successfully");
        email.clear();
        first_name.clear();
        last_name.clear();
        mobile.clear();
        password.clear();
      } else {
        JossToast(msg: "Sorry There Was a Problem",isGood: false);
        email.clear();
        first_name.clear();
        last_name.clear();
        mobile.clear();
        password.clear();
      }
    }
  }
  Future<void> login(BuildContext context, TextEditingController email,
      TextEditingController password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email.text.isEmpty || password.text.isEmpty) {
      JossToast(msg: "Fill Every Box",isGood: false);
      return;
    } else {
      var dat = {
        "email": email.text,
        "password": password.text
      };
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/Login");
      try {
        var res = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(dat),
        );
        if (res.statusCode == 200) {
          var data = jsonDecode(res.body);
          if (data['token'] != null) {
            var token = data['token'];
            await prefs.setString("token", token);
            email.clear();
            password.clear();
            getProfileDetails().then((_) {
              loadImageFromPrefs();
            }).then((_){
              Get.to(() => TaskHome());
            });
          } else {
            JossToast(isGood: false,msg: "Something Went Wrong");
          }
        } else {
          JossToast(isGood: false,msg: "Something Went Wrong");
        }
      } catch (e) {
        JossToast(isGood: false,msg: "$e");
      }
    }
  }
  Future<void> getProfileDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url = Uri.parse("http://35.73.30.144:2005/api/v1/ProfileDetails");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': '$token'
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['status'] == 'success') {
        var profile = data['data'][0];
        userInfo['id'] = profile['_id'];
        userInfo['email'] = profile['email'];
        userInfo['firstName'] = profile['firstName'];
        userInfo['lastName'] = profile['lastName'];
        userInfo['mobile'] = profile['mobile'];
        userInfo['password'] = profile['password'];
        Appbar_Name.value = profile['firstName'] + " " + profile['lastName'];
        Appbar_Email.value = profile['email'];
      }
    }
  }
  Future<void> UpdateProfile(String token, TextEditingController email,
      TextEditingController first_name, TextEditingController last_name,
      TextEditingController mobile, TextEditingController password,
      BuildContext context) async {
    var dat = {
      "email": email.text,
      "firstName": first_name.text,
      "lastName": last_name.text,
      "mobile": mobile.text,
      "password": password.text
    };
    var url = Uri.parse("http://35.73.30.144:2005/api/v1/ProfileUpdate");
    var res = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'token': token
    }, body: json.encode(dat));
    if (res.statusCode == 200) {
      final Stk = SnackBar(content: Text("Updated Successfully"));
      ScaffoldMessenger.of(context).showSnackBar(Stk);
      await getProfileDetails();
    }
  }
  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Appbar_Name.value = "";
    Appbar_Email.value = "";
    userInfo.clear();
    Get.find<TaskController>().clearAllTasks();
    JossToast(isGood: true,msg: "Logged Out Successfully");
    Get.to(() => Login());
  }
  Future<void> Cameraimage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      appbarImage.value = File(img.path);
      String uniqueKey = Appbar_Email.value.isNotEmpty ? Appbar_Email.value : "default";
      await prefs.setString('profile_pic_$uniqueKey', img.path);
      JossToast(isGood: true,msg: "Image Updated!");
    } else {
      print('No image selected.');
    }
  }
  Future<void> loadImageFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uniqueKey = Appbar_Email.value.isNotEmpty ? Appbar_Email.value : "default";
    String? savedImagePath = prefs.getString('profile_pic_$uniqueKey');
    if (savedImagePath != null && savedImagePath.isNotEmpty) {
      appbarImage.value = File(savedImagePath);
      picurl.value = savedImagePath;
    } else {
      appbarImage.value = File("");
    }
  }
  Future<void> send_otp() async {
    try {
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/RecoverVerifyEmail/${recovery_email.text.toString()}");
      print("Sending OTP to: ${recovery_email.text}");
      var res = await http.get(url, headers: {'Content-Type': 'application/json'});
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      if (res.statusCode == 200) {
        JossToast(isGood: true,msg: "OTP Sent Successfully");
        Get.to(()=>Otppage(),transition: Transition.cupertino);
      } else {
        JossToast(isGood: false,msg: "Something Went Wrong");
      }
    } catch (e) {
      print("Error: $e");
      JossToast(isGood: false,msg: "$e");

    }
  }
  Future<void>check_otp()async{
    try{
      var url = Uri.parse("http://35.73.30.144:2005/api/v1/RecoverVerifyOtp/${recovery_email.text.toString()}/${recovery_otp}");
      var res=await http.get(url,headers: {'Content-Type':'application/json'});
      if(res.statusCode==200)
      {
        JossToast(isGood: true,msg: "OTP Matched");
        Get.to(()=>Passwordpage(),transition: Transition.cupertino);
      }
      else{
        JossToast(isGood: false,msg: "Something Went Wrong");
      }
    }
    catch(e){
      JossToast(msg: "Internal Error",isGood: false);
    }
  }
  Future<void> recover_password() async {
    try {
      if (recovery_pass.text.isEmpty || recovery_pass_confirm.text.isEmpty) {
        JossToast(msg: "Fill Every Box",isGood: false);
        return;
      } else if (recovery_pass.text != recovery_pass_confirm.text) {
        JossToast(msg: "Password Not Matched",isGood: false);
        return;
      } else {
        var data = {
          "email": recovery_email.text,
          "OTP": recovery_otp.value,
          "password": recovery_pass_confirm.text,
        };

        var url = Uri.parse("http://35.73.30.144:2005/api/v1/RecoverResetPassword");
        var res = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );

        if (res.statusCode == 200) {
          JossToast(msg: "Password Reset Successful",isGood: true);
          recovery_email.clear();
          recovery_otp.value="";
          recovery_pass.clear();
          recovery_pass_confirm.clear();
          Get.to(() => Login(),transition: Transition.cupertino);
        } else {
          JossToast(msg: "Something Went Wrong",isGood: false);
        }
      }
    } catch (e) {
      JossToast(msg: "$e",isGood: false);

    }
  }
}
