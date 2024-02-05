import '../controller/trending_tab_container_controller.dart';
import '../models/stories_item_model.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StoriesItemWidget extends StatelessWidget {
  StoriesItemWidget(
    this.storiesItemModelObj, {
    Key? key,
  }) : super(
          key: key,
        );

  StoriesItemModel storiesItemModelObj;

  var controller = Get.find<TrendingTabContainerController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64.h,
      child: Column(
        children: [
          Container(
            height: 64.adaptSize,
            width: 64.adaptSize,
            padding: EdgeInsets.symmetric(
              horizontal: 4.h,
              vertical: 3.v,
            ),
            decoration: AppDecoration.outlineDeepPurpleA.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder32,
            ),
            child: Obx(
              () => CustomImageView(
                imagePath: storiesItemModelObj.roy!.value,
                height: 54.v,
                width: 52.h,
                radius: BorderRadius.circular(
                  27.h,
                ),
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(height: 10.v),
          Obx(
            () => Text(
              storiesItemModelObj.roy1!.value,
              style: theme.textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
