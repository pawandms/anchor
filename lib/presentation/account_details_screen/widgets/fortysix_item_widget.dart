import '../controller/account_details_controller.dart';
import '../models/fortysix_item_model.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FortysixItemWidget extends StatelessWidget {
  FortysixItemWidget(
    this.fortysixItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  FortysixItemModel fortysixItemModelObj;

  var controller = Get.find<AccountDetailsController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 117.h,
      child: Obx(
        () => CustomImageView(
          imagePath: fortysixItemModelObj.fortySix!.value,
          height: 161.v,
          width: 117.h,
          radius: BorderRadius.circular(
            10.h,
          ),
        ),
      ),
    );
  }
}
