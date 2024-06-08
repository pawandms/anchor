import 'dart:convert';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loggy/loggy.dart';

import '../../../core/authentication_manager.dart';
import '../../../core/errors/ApiException.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

/// LoginService responsible to communicate with web-server
/// via authenticaton related APIs
class LoginService extends GetConnect {
  final String loginUrl = 'https://reqres.in/api/login';
  final String registerUrl = 'https://reqres.in/api/register';

  Future<LoginResponseModel?> fetchLogin(LoginRequestModel model) async {
    LoginResponseModel resp = new LoginResponseModel();
    try {
      String loginUrl = '${EnvConfig.baseUrl}${EnvConfig.login}';
      var loginFromData = FormData(
          {
            'grant_type': 'password',
            'username': model.email,
            'password': model.password
          });

      Map<String, String> header = {'Authorization': EnvConfig.authHeader};
      final response = await post(loginUrl, loginFromData, headers: header);

      if (response.statusCode == HttpStatus.ok) {
       resp =  LoginResponseModel.fromMap(response.body);
      } else {
        resp =  LoginResponseModel.fromMap(response.body);
      }

    }
    catch (e) {
      logError("SignIn Error:$e");
    }
    return resp;
  }

  Future<void> updateTokenDetails() async {
    LoginResponseModel resp = new LoginResponseModel();
    try {
      AuthenticationManager _authManager = Get.find();
      if( null == _authManager)
      {
        throw ApiException('Auth manager is null on refresh token event');
      }

      LoginResponseModel? userCredentials = _authManager.getLoginResp();
      if( null == userCredentials)
      {
        throw ApiException('Auth credentials are null on refresh token event');
      }
      String? refreshToken = userCredentials!.refresh_token;

      if( null == refreshToken)
      {
        throw ApiException(' refreshToken null on refresh token event');
      }

      String loginUrl = '${EnvConfig.baseUrl}${EnvConfig.login}';
      var loginFromData = FormData(
          {
            'grant_type': 'refresh_token',
            'refresh_token': refreshToken,

          });

      Map<String, String> header = {'Authorization': EnvConfig.authHeader};
      final response = await post(loginUrl, loginFromData, headers: header);

      if (response.statusCode == HttpStatus.ok) {
        resp =  LoginResponseModel.fromMap(response.body);
      } else {
        resp =  LoginResponseModel.fromMap(response.body);
      }

        _authManager.login(resp);


    }
    catch(e, stacktrace)
    {
      Logger.log('Error in Refresh Token'+e.toString(),stackTrace: stacktrace);
    }

  }

  /*Future<RegisterResponseModel?> fetchRegister(
      RegisterRequestModel model) async {
    final response = await post(registerUrl, model.toJson());

    if (response.statusCode == HttpStatus.ok) {
      return RegisterResponseModel.fromJson(response.body);
    } else {
      return null;
    }
  }*/
}
