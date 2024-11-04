import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/myappbar.dart';
import '../components/mybutton.dart';
import '../style/style.dart';

class UpdateProfile extends StatefulWidget {
  final String token;
  UpdateProfile({super.key, required this.token});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    super.initState();
    getProfileDetails();
  }

  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  Map<String, String> userInfo = <String, String>{};
  String Appbar_Email = "";
  File appbarImage = File("");
  Future<void> getProfileDetails() async {
    var url = Uri.parse("http://35.73.30.144:2005/api/v1/ProfileDetails");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': '${widget.token}'
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['status'] == 'success') {
        var profile = data['data'][0];
       setState(() {
         userInfo['id'] = profile['_id'];
         userInfo['email'] = profile['email'];
         userInfo['firstName'] = profile['firstName'];
         userInfo['lastName'] = profile['lastName'];
         userInfo['mobile'] = profile['mobile'];
         userInfo['password'] = profile['password'];
         email.text = userInfo['email'] ?? '';
         first_name.text = userInfo['firstName'] ?? '';
         last_name.text = userInfo['lastName'] ?? '';
         mobile.text = userInfo['mobile'] ?? '';
         password.text = userInfo['password'] ?? '';
       });
      }
    }
  }
  Future<Map<String, String>> fetchUserInfo() async {
    // Replace this mock data with actual data-fetching logic
    return {
      'email': 'user@example.com',
      'firstName': 'John',
      'lastName': 'Doe',
      'mobile': '1234567890',
      'password': 'password123'
    };
  }

  Future<void> Cameraimage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    String uniqueKey = "";

    if (img != null) {
      setState(() {
        appbarImage = File(img.path);
        uniqueKey = Appbar_Email.isNotEmpty ? Appbar_Email : "default";
      });
      await prefs.setString('profile_pic_$uniqueKey', img.path);
      Fluttertoast.showToast(
        msg: "Image Updated",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    } else {
      print('No image selected.');
    }
  }

  Future<void> UpdateProfile(
      String token,
      TextEditingController email,
      TextEditingController first_name,
      TextEditingController last_name,
      TextEditingController mobile,
      TextEditingController password,
      BuildContext context,
      ) async
  {
    var dat = {
      "email": email.text,
      "firstName": first_name.text,
      "lastName": last_name.text,
      "mobile": mobile.text,
      "password": password.text
    };

    var url = Uri.parse("http://35.73.30.144:2005/api/v1/ProfileUpdate");
    var res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'token': token
      },
      body: json.encode(dat),
    );

    if (res.statusCode == 200) {
      final Stk = SnackBar(content: Text("Updated Successfully"));
      ScaffoldMessenger.of(context).showSnackBar(Stk);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.sizeOf(context).width;
    var mdh = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: Myappbar(autobar: true),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/background.svg",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  Text("Update Profile", style: H1text(mdw)),
                                ],
                              ),
                            ),
                            SizedBox(height: mdh * 0.035),
                            Container(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  appbarImage.path.isNotEmpty
                                      ? Hero(
                                    tag: "pic",
                                    child: CircleAvatar(
                                      backgroundImage: FileImage(appbarImage),
                                      radius: 44,
                                    ),
                                  )
                                      : Hero(
                                    tag: "pic",
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/user.png"),
                                      radius: 44,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -5,
                                    right: 5,
                                    child: IconButton(
                                      onPressed: Cameraimage,
                                      icon: Icon(Icons.edit, color: MythemeColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: mdh * 0.012),
                            TextFormField(
                              readOnly: true,
                              controller: email,
                              decoration: InputDecoration(hintText: "Email"),
                            ),
                            SizedBox(height: mdh * 0.012),
                            TextFormField(
                              controller: first_name,
                              decoration: InputDecoration(hintText: "First Name"),
                            ),
                            SizedBox(height: mdh * 0.012),
                            TextFormField(
                              controller: last_name,
                              decoration: InputDecoration(hintText: "Last Name"),
                            ),
                            SizedBox(height: mdh * 0.012),
                            TextFormField(
                              controller: mobile,
                              decoration: InputDecoration(hintText: "Mobile"),
                            ),
                            SizedBox(height: mdh * 0.012),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(hintText: "Password"),
                            ),
                            SizedBox(height: mdh * 0.035),
                            Mybutton(
                              onpressed: () {
                                UpdateProfile(
                                  widget.token,
                                  email,
                                  first_name,
                                  last_name,
                                  mobile,
                                  password,
                                  context,
                                );
                              },
                              something: Icon(
                                Icons.arrow_circle_right_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
