
import 'dart:convert';

import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:dart_nats/dart_nats.dart';
//import 'package:nats_client/natslite/constants.dart';
//import 'package:nats_client/natslite/nats.dart';

class NatsClientConfig extends  GetxService {

  late Client natsClient;

  AsciiDecoder asciiDecoder  = AsciiDecoder();
  @override
  Future<void> onInit() async {
    try{

      String wsUrl = EnvConfig.natUrl;
      Uri uri = Uri.parse(wsUrl);
      natsClient = Client();
      await natsClient.connect(uri, retry: true, retryInterval: 5, retryCount: 100);

      /*
      var sub = natsClient.sub('3500_2024.>');
      sub.stream.listen((event) {
        print(event.subject);
        String msg = asciiDecoder.convert(event.data);
        print("Msg:"+msg);
         // printStreamData(event.header.toString(), event.data.toString());
      });
      */

      /*
      var msg = await sub.stream.first;
      print("Nats Msg:"+msg.string);
      */
      natsClient.statusStream.listen((status){


        //
        print(status);
      });
      /*

      conn = Nats(opts: {}, debug: true,
        statusCallback: (status, error) async {
        if (error != null) {
          print('NetService:ERROR $error');
        }
        if (status == Status.PING_TIMER) {
          print(status.toString());
        } else if (status == Status.CONNECT) {
          // sync request
          print("Connected to Server");

          }
        }

      );

      conn.init(wsUrl);
      */
    }
    catch(e)
    {
      printError(info: "Exception on Nats Client:$e");
      rethrow;


    }

  }


}