import 'package:assignment5/screens/card.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController proname=TextEditingController();
  TextEditingController procode=TextEditingController();
  TextEditingController proqty=TextEditingController();
  TextEditingController prounit=TextEditingController();
  @override
  void initState() {
    super.initState();
    READ();
  }
  List<dynamic> arr = [];
  Future<void> READ() async {
    var url = Uri.parse("http://164.68.107.70:6060/api/v1/ReadProduct");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var jsonResponse = jsonDecode(res.body);
      setState(() {
        arr = jsonResponse['data'];
        print(arr);
      });
    } else {
      print("Failed to load data");
    }
  }
  Future<void> CREATE() async {
    var dat={
      "ProductCode":procode.text,
      "ProductName":proname.text,
      "Qty":proqty.text,
      "TotalPrice":int.parse(proqty.text)*int.parse(prounit.text),
      "UnitPrice":prounit.text
    };
    var url = Uri.parse("http://164.68.107.70:6060/api/v1/CreateProduct");
    var res = await http.post(url,
      headers: {'Content-Type':'application/json'},
      body: json.encode(dat)
    );
    if (res.statusCode == 200) {
      READ();
      delete_fields();
      Navigator.of(context).pop();
    } else {
      print("Failed to load data");
    }
  }
  Future<void> DELETE(String id)
  async{
    var url=Uri.parse("http://164.68.107.70:6060/api/v1/DeleteProduct/$id");
    var res=await http.get(url);
    if(res.statusCode==200)
      {
        READ();
      }
  }
  void delete_fields()
  {
    proname.clear();
    procode.clear();
    proqty.clear();
    prounit.clear();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Products"),
        backgroundColor: CupertinoColors.white,
        trailing: Icon(CupertinoIcons.cart),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 650,
                margin: EdgeInsets.all(15),
                child: arr.isEmpty?Container(child: CupertinoActivityIndicator(),):GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: arr.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      productname: arr[index]['ProductName'].toString(),
                      productcode: arr[index]['ProductCode'].toString(),
                      qty: arr[index]['Qty'].toString(),
                      uprice: arr[index]['UnitPrice'].toString(),
                      totalprice: arr[index]['TotalPrice'].toString(),
                      delete: () => DELETE(arr[index]['_id']),
                      read: () => READ(),
                      idx: arr[index]['_id'],
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: CupertinoButton.filled(
                    child: Text("ADD PRODUCTS",style: TextStyle(fontWeight: FontWeight.bold),), onPressed: () {
                      showCupertinoDialog(context: context, builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Add Product"),
                          content: Column(children: [
                            CupertinoTextField(
                              controller: proname,
                               placeholder: "Product Name",
                            ),
                            SizedBox(height: 5,),
                            CupertinoTextField(
                              controller: procode,
                              placeholder: "Product Code",
          
                            ),
                            SizedBox(height: 5,),
                            CupertinoTextField(
                              controller: proqty,
                              placeholder: "Product Quantity",
                            ),
                            SizedBox(height: 5,),
                            CupertinoTextField(
                              controller: prounit,
                              placeholder: "Product Unit Price",
                            ),
                            SizedBox(height: 5,),
                          ],
                          ),
                          actions: [
                            CupertinoButton(child: Text("Add Product"), onPressed: (){CREATE();}),
                            CupertinoButton(child: Text("Cancel"), onPressed: (){
                              Navigator.of(context).pop();
                            })
                          ],
                        );
                      },);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
