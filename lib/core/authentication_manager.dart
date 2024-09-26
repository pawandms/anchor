import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

import '../presentation/log_in_screen/models/login_response_model.dart';
import 'cache_manager.dart';

class AuthenticationManager extends GetxService with CacheManager {
  Future<AuthenticationManager> init() async => this;
 // static AuthenticationManager get to => Get.find();

  final isLogged = false.obs;
  bool get isLoggedInValue => isLogged.value;

  Future<void> logOut() async {
    await removeLoginResp();
    isLogged.value = false;
    //removeToken();
  }

  void login(LoginResponseModel resp) async {
    //Token is cached
    await saveLoginResp(resp);
    isLogged.value = true;

  }

  bool isUserLoggedIn()
  {
    bool result = false;
    final resp = getLoginResp();
    if (resp != null) {
      result = true;
    }
    return result;
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
