import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:get/get.dart';
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
    Get_My_Info();
  }

  TextEditingController email = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  UserController user = Get.find();
  void Get_My_Info() async {
    email.text = await user.userInfo['email'] ?? '';
    first_name.text = await user.userInfo['firstName'] ?? '';
    last_name.text = await user.userInfo['lastName'] ?? '';
    mobile.text = await user.userInfo['mobile'] ?? '';
    password.text = await user.userInfo['password'] ?? '';
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
                                  children: [
                                    Text("Update Profile", style: H1text(mdw)),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                )),
                            SizedBox(
                              height: mdh * 0.035,
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Stack(children: [
                                  Obx(() {
                                    if (user
                                        .appbarImage.value.path.isNotEmpty) {
                                      return Hero(
                                        tag: "pic",
                                        child: CircleAvatar(
                                          backgroundImage:
                                              FileImage(user.appbarImage.value),
                                          radius: 44,
                                        ),
                                      );
                                    } else {
                                      return Hero(
                                        tag: "pic",
                                        child: CircleAvatar(
                                          backgroundImage:
                                              AssetImage("assets/user.png"),
                                          radius: 44,
                                        ),
                                      );
                                    }
                                  }),
                                  Positioned(
                                    bottom: -5,
                                    right: 5,
                                    child: IconButton(
                                        onPressed: () {
                                          user.Cameraimage();
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: MythemeColor,
                                        )),
                                  )
                                ])),
                            SizedBox(
                              height: mdh * 0.012,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: email,
                              decoration: InputDecoration(hintText: "Email"),
                            ),
                            SizedBox(
                              height: mdh * 0.012,
                            ),
                            TextFormField(
                              controller: first_name,
                              decoration:
                                  InputDecoration(hintText: "First Name"),
                            ),
                            SizedBox(
                              height: mdh * 0.012,
                            ),
                            TextFormField(
                              controller: last_name,
                              decoration:
                                  InputDecoration(hintText: "Last Name"),
                            ),
                            SizedBox(
                              height: mdh * 0.012,
                            ),
                            TextFormField(
                              controller: mobile,
                              decoration: InputDecoration(hintText: "Mobile"),
                            ),
                            SizedBox(
                              height: mdh * 0.012,
                            ),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(hintText: "Password"),
                            ),
                            SizedBox(
                              height: mdh * 0.035,
                            ),
                            Mybutton(
                                onpressed: () {
                                  user.UpdateProfile(
                                      widget.token,
                                      email,
                                      first_name,
                                      last_name,
                                      mobile,
                                      password,
                                      context);
                                },
                                something: Icon(
                                  Icons.arrow_circle_right_outlined,
                                  color: Colors.white,
                                ))
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
