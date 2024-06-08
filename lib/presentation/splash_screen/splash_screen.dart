import 'controller/splash_controller.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/material.dart';

class SplashScreen extends GetWidget<SplashController> {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.deepPurpleA200,
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                          imagePath: ImageConstant.imgSocialMedia1,
                          color: Colors.white,
                          height: 120.adaptSize,
                          width: 120.adaptSize),
                      SizedBox(height: 20.v),
                      Text("lbl_social".tr,
                          style: theme.textTheme.displaySmall),
                      SizedBox(height: 5.v)
                    ]))));
  }
}
