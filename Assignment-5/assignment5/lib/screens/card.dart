import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCard extends StatelessWidget {
  final String productname;
  final String productcode;
  final String qty;
  final String uprice;
  final String totalprice;
  final String idx;
  final VoidCallback delete;
  final VoidCallback read;

  ProductCard({
    required this.productname,
    required this.productcode,
    required this.qty,
    required this.uprice,
    required this.totalprice,
    required this.delete,
    required this.idx,
    required this.read,
  });

  final TextEditingController upproname = TextEditingController();
  final TextEditingController upprocode = TextEditingController();
  final TextEditingController upproqty = TextEditingController();
  final TextEditingController upprounit = TextEditingController();

  Future<void> UPDATE(BuildContext context) async {
    var dat = {
      "ProductCode": upprocode.text,
      "ProductName": upproname.text,
      "Qty": upproqty.text,
      "TotalPrice": int.parse(upproqty.text)*int.parse(upprounit.text),
      "UnitPrice": upprounit.text,
    };
    var url = Uri.parse("http://164.68.107.70:6060/api/v1/UpdateProduct/$idx");
    var res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dat),
    );
    if (res.statusCode == 200) {
      delete_fields();
      Navigator.of(context).pop();
      read();
    }
  }
  void delete_fields()
  {
    upproname.clear();
    upprocode.clear();
    upproqty.clear();
    upprounit.clear();
  }
  void showUpdateDialog(BuildContext context) {
    upproname.text = productname;
    upprocode.text = productcode;
    upproqty.text = qty;
    upprounit.text = uprice;

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Update Product"),
          content: Column(
            children: [
              CupertinoTextField(
                controller: upproname,
                placeholder: "Product Name",
              ),
              SizedBox(height: 5),
              CupertinoTextField(
                controller: upprocode,
                placeholder: "Product Code",
              ),
              SizedBox(height: 5),
              CupertinoTextField(
                controller: upproqty,
                placeholder: "Quantity",
              ),
              SizedBox(height: 5),
              CupertinoTextField(
                controller: upprounit,
                placeholder: "Unit Price",
              ),
            ],
          ),
          actions: [
            CupertinoButton(
              child: Text("Update"),
              onPressed: () {
                UPDATE(context);
              },
            ),
            CupertinoButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CupertinoColors.secondarySystemBackground,
      ),
      height: 170,
      width: 200,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Icon(CupertinoIcons.pen),
                    onTap: () {
                      showUpdateDialog(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Icon(CupertinoIcons.delete),
                    onTap: delete,
                  ),
                ),
              ],
            ),
          ),
          Text(
            productname,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 5),
          Text(
            productcode,
            style: TextStyle(fontSize: 17),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Text(
            "Quantity: x$qty",
            style: TextStyle(fontSize: 18),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Text(
            "Unit Price: $uprice",
            style: TextStyle(fontSize: 19),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5),
          Text(
            "Total Price: $totalprice",
            style: TextStyle(fontSize: 19),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
