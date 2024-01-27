import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/daily_new_page/models/daily_new_model.dart';

/// A controller class for the DailyNewPage.
///
/// This class manages the state of the DailyNewPage, including the
/// current dailyNewModelObj
class DailyNewController extends GetxController {
  DailyNewController(this.dailyNewModelObj);

  Rx<DailyNewModel> dailyNewModelObj;
}
