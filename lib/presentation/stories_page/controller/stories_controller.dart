import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/stories_page/models/stories_model.dart';
import 'package:flutter/material.dart';

/// A controller class for the StoriesPage.
///
/// This class manages the state of the StoriesPage, including the
/// current storiesModelObj
class StoriesController extends GetxController {
  StoriesController(this.storiesModelObj);

  TextEditingController searchController = TextEditingController();

  Rx<StoriesModel> storiesModelObj;

  @override
  void onClose() {
    super.onClose();
    searchController.dispose();
  }
}
