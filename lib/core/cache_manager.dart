import 'package:get_storage/get_storage.dart';

import '../presentation/log_in_screen/models/login_response_model.dart';

mixin CacheManager {
  Future<bool> saveAccessToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.access_token.toString(), token);
    return true;
  }

  String? getAccessToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.access_token.toString());
  }

  Future<void> removeAccessToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.access_token.toString());
  }

  Future<bool> saveLoginResp(LoginResponseModel? model) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.login_response.toString(), model);
    return true;
  }

  LoginResponseModel? getLoginResp() {
    final box = GetStorage();
    return  box.read(CacheManagerKey.login_response.toString()) ;
  }

  Future<void> removeLoginResp() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.login_response.toString());
  }
}

enum CacheManagerKey { access_token, refresh_token, login_response  }
