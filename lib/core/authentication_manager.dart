import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import '../presentation/log_in_screen/models/login_response_model.dart';
import 'cache_manager.dart';

class AuthenticationManager extends GetxService with CacheManager {

  Future<AuthenticationManager> init() async => this;
  final isLogged = false.obs;

  void logOut() {
    isLogged.value = false;
    //removeToken();
  }

  void login(LoginResponseModel resp) async {
    isLogged.value = true;
    //Token is cached
    await saveLoginResp(resp);
  }

  void checkLoginStatus() {
    final resp = getLoginResp();
    if (resp != null) {
      isLogged.value = true;
    }
  }

  LoginResponseModel? getUserLoginDetails()  {
    return getLoginResp();
  }
}
