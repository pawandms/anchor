
import 'dart:convert';

import 'package:anchor_getx/core/enums/EventType.dart';
import 'package:anchor_getx/presentation/messages_page/service/message_service.dart';
import 'package:dart_nats/dart_nats.dart';
import 'package:anchor_getx/core/app_export.dart';


import '../../data/apiClient/api_client.dart';
import '../model/Event.dart';
import '../network/NatsClientConfig.dart';

class EventService extends GetxService{

  late Client natsClient;
  AsciiDecoder asciiDecoder  = AsciiDecoder();

   MessageService? messageService;
   ApiClient? apiClient;

  @override
  void onInit() {
    NatsClientConfig natsConfig = Get.find();
    natsClient = natsConfig.natsClient;

  }

  void addSubscription(String subscription)
  {
    natsClient.sub(subscription).stream.listen((event) {
      processEvent(event.subject!, asciiDecoder.convert(event.data));
    });
  }

  void processEvent(String subjet, String data)
  {

    try{
      Map<String,dynamic> jsonMap = jsonDecode(data);
      Event event =  Event.fromMap(jsonMap);

      if( null == messageService)
      {
        messageService = Get.find<MessageService>();
      }
      if( null == apiClient)
      {
        apiClient  = Get.find<ApiClient>();

      }

      String? logInUser = apiClient?.getLoggedInUserID();
      if(null != event.type) {

        switch(event.type)
        {
          case EventType.Chnl_Add_Msg:
            processMsgAddToChnl(logInUser, event);
          break;

          default:

        }
      }

      Logger.log("Event Received:$event");
    }
    catch(e, stacktrace)
    {
      Logger.log(e.toString(),stackTrace: stacktrace);
    }

  }

  void processMsgAddToChnl(String? logInUser, Event event)
  {

    if(( null != event.author)
        && (null != logInUser)
      && (event.author.toUpperCase() != logInUser.toUpperCase()))
     {
      messageService?.addNewMsgToChnl(event.entityId, event.message);
     }
  }

  void addEventForChannels(Iterable<String> chnlIds)
  {
    if(chnlIds.isNotEmpty)
     {
       chnlIds.forEach((chId) {
        String subscription = "chnl.$chId.>";
        addSubscription(subscription);
       });
     }

  }

}