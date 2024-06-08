import 'dart:developer';
import 'dart:io';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:anchor_getx/data/enums/EntityType.dart';
import 'package:anchor_getx/data/models/channel/ChannelResp.dart';
import 'package:anchor_getx/data/models/user/User.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:loggy/loggy.dart';

import '../../core/authentication_manager.dart';
import '../../presentation/log_in_screen/models/login_response_model.dart';
import '../../presentation/log_in_screen/service/login_service.dart';
import '../enums/MediaInputType.dart';

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

        //LoginResponseModel? userCredentials = _authManager.getLoginResp();
        LoginService _loginService = Get.find();
       await  _loginService.updateTokenDetails();
        LoginResponseModel? userCredentials = _authManager.getLoginResp();
        String? accessToken =  userCredentials?.access_token;

        // Login Credentials are present into Memory
        if(( null != accessToken))
        {
            request.headers['Authorization'] =
            'Bearer $accessToken';

        }
        else {
          log('addAuthenticator Login Credentails not present in memory');
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
      log('call addRequestModifier ${request.url.toString()} With Header:${request.headers}');
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

  User? getLoggedInUser()
  {
    LoginResponseModel? userCredentials = _authManager.getLoginResp();
    return userCredentials?.user;

  }

  String? getAccessToken()
  {
    String? token = null;
    LoginResponseModel? userCredentials = _authManager.getLoginResp();

    if(( null != userCredentials) || (null != userCredentials?.access_token))
    {
      String? accessTkn = userCredentials!.access_token;
      if(null != accessTkn)
      {
        token = accessTkn;
      }

      }

    return token;
  }

  String getContentUrl(String contentId, EntityType type)
  {
    String result = 'images/image_not_found.png';
    String? token = getAccessToken();
    if( null != token)
    {
      if(type == EntityType.UserProfile)
      {

        result= EnvConfig.baseUrl+EnvConfig.getProfileImageUrl(contentId, token);
      }
    }

    return result;
  }

  String getAttachmentUrl(String contentId, String extension, int cntLength, MediaInputType type)
  {
    String result = 'images/image_not_found.png';
    String? token = getAccessToken();
    if( null != token)
    {
        result= EnvConfig.baseUrl+EnvConfig.getAttachmentUrl(contentId,extension, cntLength, type, token);
    }

    return result;
  }

}
