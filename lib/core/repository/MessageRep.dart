
import 'dart:html';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/data/apiClient/api_client.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:loggy/loggy.dart';

import '../../data/models/message/ChnlMsgResp.dart';
import '../constants/env_config.dart';

class MessageRep extends GetxService
{
  late final ApiClient apiClient;

  @override
  void onInit() {
    apiClient = Get.find<ApiClient>();

  }

  Future<ChnlMsgResp> getChnlMsgForUser(String userID, String chnlID, int itemsPerPage, int page)
   async {
     ChnlMsgResp resp = new ChnlMsgResp(content: [], totalPages: 0, number: 0, first: false, last: false, empty: true, size: 0, totalElements: 0, numberOfElements: 0);
    try{
      String chnlUrl = EnvConfig.getChnlMsgUrl(userID,chnlID);
      Map<String, String> queryParam = {"page": page.toString(), "size": itemsPerPage.toString()};
      final response = await apiClient.get(chnlUrl,headers:{}, contentType : null, query: queryParam);
      if (response.statusCode == HttpStatus.ok) {
        resp =  ChnlMsgResp.fromMap(response.body);
      } else {
        resp =  ChnlMsgResp.fromMap(response.body);
      }

    }catch(e)
    {
      logError(e);
      rethrow;
    }
    return resp;
  }

}