import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/for_you_screen/models/for_you_model.dart';

/// A controller class for the ForYouScreen.
///
/// This class manages the state of the ForYouScreen, including the
/// current forYouModelObj
class ForYouController extends GetxController {
  Rx<ForYouModel> forYouModelObj = ForYouModel().obs;
}
