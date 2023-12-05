import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastApp {
  static Function(String msg) error = (String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

  static Function(String msg) info = (String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.blue,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        textColor: Colors.white,
      );
  static Function(String msg) success = (String msg) => Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        textColor: Colors.white,
      );
}
