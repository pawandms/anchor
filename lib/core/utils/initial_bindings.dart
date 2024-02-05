import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/apiClient/api_client.dart';

import '../authentication_manager.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
    //final AuthenticationManager _authmanager = Get.put(AuthenticationManager());
  }

}
