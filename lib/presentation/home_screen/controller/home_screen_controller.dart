import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/presentation/stories_container_screen/models/stories_container_model.dart';

import '../../message_screen/controller/messageScreenController.dart';
import '../models/home_screen_model.dart';

/// A controller class for the StoriesContainerScreen.
///
/// This class manages the state of the StoriesContainerScreen, including the
/// current storiesContainerModelObj
class HomeScreenController extends GetxController {

  late MessageScreenController msgScrController;
  Rx<HomeScreenModel> homeScreenModelObj =
      HomeScreenModel().obs;

  @override
  void onInit() {
    bool isMsgControllerRegistered = Get.isRegistered<MessageScreenController>();
    print('MsgScreen Controller is Registered with Home Screen Result:${isMsgControllerRegistered}');
    if(isMsgControllerRegistered)
    {
      this.msgScrController = Get.find<MessageScreenController>();
    }
    else {
      this.msgScrController = Get.put(MessageScreenController());
    }

  }
}
