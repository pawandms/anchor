import 'dart:developer';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:anchor_getx/data/models/channel/ChannelResp.dart';
import 'package:loggy/loggy.dart';

import '../../core/authentication_manager.dart';
import '../../presentation/log_in_screen/models/login_response_model.dart';

class ApiClient extends GetConnect {

  late final AuthenticationManager _authManager;
  int retry = 0;
  @override
  void onInit() {
    _authManager = Get.find();
    httpClient.baseUrl = EnvConfig.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.maxAuthRetries =  3;
    httpClient.followRedirects = true;

    //addAuthenticator only is called after
//a request (get/post/put/delete) that returns HTTP status code 401
    httpClient.addAuthenticator<dynamic>((request) async {
      try{
        retry--;
        log('addAuthenticator ${request.url.toString()}');

        LoginResponseModel? userCredentials = _authManager.getLoginResp();
        // Login Credentials are present into Memory
        if(( null != userCredentials) || (null != userCredentials?.access_token))
        {
          String? accessTkn = userCredentials!.access_token;
          if(null != accessTkn)
          {
            request.headers['Authorization'] =
            'Bearer $accessTkn';
          }
        }
        else {

          // Login credentials not present into Memory
        }
      }
      catch(e)
      {
        printError(info: e.toString());
      }

      return request;
    });


    // Add Access Token to in API Call
    httpClient.addRequestModifier<dynamic>((request) async {

      printInfo(
          info:
          'Expired in: $request');
      // log('call addRequestModifier , ${request.headers}');
      LoginResponseModel? userCredentials = _authManager.getLoginResp();

      if(( null != userCredentials) || (null != userCredentials?.access_token))
      {
        String? accessTkn = userCredentials!.access_token;
        if(null != accessTkn)
        {
          request.headers['Authorization'] =
          'Bearer $accessTkn';
        }
      }
      return request;
    });

  }

  String? getLoggedInUserID()
  {
    String? userID;
    {
      LoginResponseModel? userCredentials = _authManager.getLoginResp();
      userID = userCredentials?.user?.uid;

    }
    return userID;
  }


}
