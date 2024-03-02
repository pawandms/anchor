import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/network/NatsClientConfig.dart';
import 'package:anchor_getx/core/network/SocketIoClientConfig.dart';
import 'package:anchor_getx/core/service/EventService.dart';
import 'package:anchor_getx/data/apiClient/api_client.dart';
import 'package:anchor_getx/presentation/messages_page/service/message_service.dart';

import '../authentication_manager.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    //Get.put(SocketIoClientConfig());
    Get.put(NatsClientConfig());
    Get.put(EventService());
    Get.put(MessageService());


    //final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  }

}
