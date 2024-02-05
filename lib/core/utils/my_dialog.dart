
import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class MyDialog {

  static void showCustomSnackBar(String message, {bool isError = true, String title="Errors"}) {

    Get.snackbar(
      title,
      message,
      titleText: Text(title, style:TextStyle(color: Colors.black) ),

      messageText: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
      colorText: Colors.white,
      backgroundColor: isError?Colors.red.shade100:Colors.blue.shade50,
      borderRadius: 20,
      margin: EdgeInsets.all(10),
      animationDuration: Duration(milliseconds: 6000),
     /* backgroundGradient: LinearGradient(
        colors: [Colors.red, Colors.green],
      ),*/


    );


  }

//info
  static void info(String msg) {
    Get.snackbar('Info', msg,
        backgroundColor: Colors.blue.withOpacity(.7), colorText: Colors.white);
  }

//success
  static void success(String msg) {
    Get.snackbar('Success', msg,
        backgroundColor: Colors.green.withOpacity(.7), colorText: Colors.white);
  }

//error
  static void error(String msg) {
    Get.snackbar('Error', msg,
        backgroundColor: Colors.redAccent.withOpacity(.7),
        colorText: Colors.white);
  }

  //loading dialog
  /*static void showLoadingDialog() {
    Get.dialog(const Center(child: CustomLoading()));
  }*/
}