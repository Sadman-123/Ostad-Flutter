import 'package:flutter/material.dart';
import 'package:task_manager/controller/task_controller.dart';
import 'package:task_manager/controller/user_controller.dart';
import 'package:task_manager/initial_screens/update_profile.dart';
import 'package:task_manager/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
class Myappbar extends StatelessWidget implements PreferredSizeWidget {
  final bool autobar;
  Myappbar({super.key, required this.autobar});
  UserController user = Get.find();
  TaskController task = Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: autobar,
      backgroundColor: MythemeColor,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              final String? token = prefs.getString('token');
              Get.to(() => UpdateProfile(token: token!));
            },
            child: Obx((){
              if(user.appbarImage.value.path.isNotEmpty)
                {
                  return Hero(
                    tag: "pic",
                    child: CircleAvatar(
                      radius: 23,
                      backgroundImage: FileImage(user.appbarImage.value),
                    ),
                  );
                }
              else{
              return Hero(
                tag:"pic",
                child: CircleAvatar(
                radius: 23,
                child: Image.asset("assets/user.png")
                ),
              );
              }
            })
          ),
          SizedBox(width: mdw * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(user.Appbar_Name.value, style: Appbar_Username(mdw))),
                Obx(() => Text(user.Appbar_Email.value, style: Appbar_Email(mdw))),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              user.logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
