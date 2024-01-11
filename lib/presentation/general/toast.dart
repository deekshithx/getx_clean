import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future customTextToast(String msg) async {
  await Fluttertoast.showToast(
      backgroundColor: Colors.white,
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.black);
}
