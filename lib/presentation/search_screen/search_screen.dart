import 'package:anchor_getx/presentation/search_screen/widgets/contactsearches_item_widget.dart';

import '../search_screen/widgets/recentsearches_item_widget.dart';
import 'controller/search_controller.dart';
import 'models/contact_item_model.dart';
import 'models/recentsearches_item_model.dart';
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/widgets/app_bar/appbar_leading_image.dart';
import 'package:anchor_getx/widgets/app_bar/custom_app_bar.dart';
import 'package:anchor_getx/widgets/custom_search_view.dart';
import 'package:flutter/material.dart' hide SearchController;

// ignore_for_file: must_be_immutable
class SearchScreen extends GetWidget<SearchController> {
  const SearchScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(vertical: 20.v),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: Text(
                    "lbl_search".tr,
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
              ),
              SizedBox(height: 14.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: CustomSearchView(
                  controller: controller.searchController,
                  hintText: "lbl_search".tr,
                  onChanged:controller.searchString ,
                ),
              ),
              SizedBox(height: 28.v),
              _buildSearchClearAll(),
              SizedBox(height: 24.v),
              _buildRecentSearches(),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchClearAll() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_recently".tr,
            style: CustomTextStyles.titleLargeDeeppurpleA200Bold,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.v),
            child: Text(
              "lbl_clear_all".tr,
              style: CustomTextStyles.titleMediumDeeppurpleA200,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgVector,
        margin: EdgeInsets.fromLTRB(19.h, 16.v, 377.h, 16.v),
        onTap: () => {
        Get.rootDelegate.popRoute()
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRecentSearches() {
    return Obx(
      () => ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0.v),
            child: SizedBox(
              width: double.maxFinite,
              child: Divider(
                height: 2.v,
                thickness: 2.v,
                color: theme.colorScheme.secondaryContainer,
              ),
            ),
          );
        },
        itemCount:controller.recentsearchesItemList.value.length,
           // controller.searchModelObj.value.recentsearchesItemList.value.length,
        itemBuilder: (context, index) {
          ContactItemModel model = controller.recentsearchesItemList.value[index];
          return ContactsearchesItemWidget(
            model,
          );
        },
      ),
    );
  }
}
