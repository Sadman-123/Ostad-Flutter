import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class JossToast {
  final String msg;
  final bool isGood;
  JossToast({required this.msg, required this.isGood}) {
    _showToast();
  }
  void _showToast() {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isGood ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
