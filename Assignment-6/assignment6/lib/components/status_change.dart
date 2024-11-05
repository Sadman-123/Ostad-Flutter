import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../style/style.dart';
void showStatusChangeSheet(BuildContext context, double mdw,double mdh,String status,String id,VoidCallback Refresh) {
  Future<void>update_STATUS(String id,String current,String type)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    var url=Uri.parse("http://35.73.30.144:2005/api/v1/updateTaskStatus/$id/$type");
    var res=await http.get(url,headers: {
      'Content-Type':'application/json',
      'token':'$token'
    });
    if(res.statusCode==200)
    {
      Refresh();
      Fluttertoast.showToast(msg: "Status Changed",gravity: ToastGravity.BOTTOM);
    }
  }
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Status Change",
                style: Task_Card_Title(mdw),
              ),
            ),
             Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(child: status_changer_button(mdw, mdh, status=="New"?"assets/checked.png":"assets/new.png", status=="New"?"Completed":"New"),onTap: (){
                  update_STATUS(id,status, status=="New"?"Completed":"New").then((_)async{
                  });
                },),
                GestureDetector(child: status_changer_button(mdw, mdh, "assets/work-in-progress.png", "Progress"),onTap: (){
                  update_STATUS(id, status,"Progress");
                },),
                GestureDetector(child: status_changer_button(mdw, mdh, "assets/prohibition.png", "Cancelled"),onTap: (){
                  update_STATUS(id,status, "Cancelled");
                },),
              ],
            )
          ],
        ),
      );
    },
  );
}
Widget status_changer_button(double mdw,double mdh,String picurl,String txt)
{
  return Container(
    decoration: BoxDecoration(
        color: Color(0xFFdee2e6),
        borderRadius: BorderRadius.circular(24)
    ),
    height: mdh*0.125,
    width: mdw*0.25,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("$picurl",width: mdw*0.12,),
        SizedBox(height: mdh*0.005,),
        Text("$txt",style: Sum_Tile_Title(mdw),)
      ],
    ),
  );
}