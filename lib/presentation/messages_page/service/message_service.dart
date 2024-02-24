
import 'dart:collection';
import 'dart:html';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:anchor_getx/data/enums/ChannelType.dart';
import 'package:anchor_getx/data/models/channel/ChannelResp.dart';
import 'package:anchor_getx/presentation/message_screen/models/StateModel.dart';
import 'package:get/get_connect/connect.dart';
import 'package:loggy/loggy.dart';

import '../../../core/authentication_manager.dart';
import '../../../core/errors/ApiException.dart';
import '../../../data/apiClient/api_client.dart';

class MessageService extends GetxService  {

  //final GetConnect connect = Get.find<GetConnect>();
  late final ApiClient apiClient;

  @override
  void onInit() {
    apiClient = Get.find<ApiClient>();
    print("Api Client Init done");
  }

/*
  Future<List<StateModel>> getStateModel()
  async {
    late List<StateModel> modelList;
    try{
      const String url =
          'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

      final response = await connect.get(url,headers:{}, contentType : null, query: {});
      modelList = StateModel.listFromJson(response.body);
    }
    catch(e)
    {

    }

    return modelList;
}

 */

  Future<ChannelResp> getUserChannels() async
  {
    ChannelResp resp;
    try{
      print("MsgService:getUserChannel Called");
      String? userID = apiClient.getLoggedInUserID();
      if(null == userID)
      {
        throw new ApiException("Invalid logged in User");
      }

     // String chnlUrl = EnvConfig.getChannel;
      Map<String, dynamic>? queryParam = {'userID': userID, 'chnlType': ChannelType.Messaging.name};
      String getChnlUrl = EnvConfig.getMsgChnlUrl(userID);
      final response = await apiClient.get(getChnlUrl,headers:{}, contentType : null, query: {});
      print("getChannel Api Response:"+response.toString());
    //  resp = new ChannelResp(userID: "abc", type: ChannelType.Messaging);

      if (response.statusCode == HttpStatus.ok) {
        resp =  ChannelResp.fromMap(response.body);
        print("response:"+resp.toString());
      } else {
        resp =  ChannelResp.fromMap(response.body);
      }


    }
    catch(e)
    {
      logError("getUserChannelError:$e");
      rethrow;
    }
   return resp;

  }

}
