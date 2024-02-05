import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/daily_new_tab_container_screen/models/daily_new_tab_container_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the DailyNewTabContainerScreen.
///
/// This class manages the state of the DailyNewTabContainerScreen, including the
/// current dailyNewTabContainerModelObj
class DailyNewTabContainerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  Rx<DailyNewTabContainerModel> dailyNewTabContainerModelObj =
      DailyNewTabContainerModel().obs;

  late TabController tabviewController =
      Get.put(TabController(vsync: this, length: 4));

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
