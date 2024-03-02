
import 'package:anchor_getx/core/app_export.dart';
import 'package:anchor_getx/core/constants/env_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketIoClientConfig extends  GetxService {

  late IO.Socket socket;
  @override
  void onInit() async {
    initSocket();
  }


  initSocket() {
    String wsUrl = EnvConfig.wsUrl;

    socket = IO.io(wsUrl, <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    socket.onError((err) => print(err));
    socket.on('chat_message', (data){
      print("SocketIO Msg Received"+data.toString());
    });
  }



}