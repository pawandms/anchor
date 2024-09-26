import '../controller/search_controller.dart';
import '../models/contact_item_model.dart';
import '../models/recentsearches_item_model.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart' hide SearchController;

// ignore: must_be_immutable
class ContactsearchesItemWidget extends StatelessWidget {
  ContactsearchesItemWidget(
    this._itemModel, {
    Key? key,
  }) : super(
          key: key,
        );

  ContactItemModel _itemModel;

  var controller = Get.find<SearchController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
              imagePath: _itemModel.kevinAllsrub!,
              height: 50.adaptSize,
              width: 50.adaptSize,
              radius: BorderRadius.circular(
                25.h,
              ),
              margin: EdgeInsets.only(bottom: 18.v),
            ),

          Padding(
            padding: EdgeInsets.only(
              left: 24.h,
              top: 2.v,
              bottom: 17.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    _itemModel.kevinAllsrub1!,
                    style: theme.textTheme.titleLarge,
                  ),

                SizedBox(height: 5.v),
                Text(
                    _itemModel.yourEFriendsOn!,
                    style: CustomTextStyles.bodyMediumGray600,
                  ),

              ],
            ),
          ),
          Spacer(),
          CustomOutlinedButton(
            width: 76.h,
            text: "lbl_follow".tr,
            margin: EdgeInsets.only(
              top: 9.v,
              bottom: 26.v,
            ),
          ),
        ],
      ),
    );
  }
}
