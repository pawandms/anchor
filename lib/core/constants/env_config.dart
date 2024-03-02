
import '../../data/enums/ChannelType.dart';

class EnvConfig{
  static const String baseUrl = 'http://192.168.0.195:8080';
  static const String authHeader = 'Basic R2VuZXJhbDpHZW5lcmFs';
  static const String register = '/public/signup';
  static const String login = '/oauth/token';
  static const String allUsers = '/users/all';
  static const String userEmail = '/users/email';
  static const String profile = '/users/profile';
  static const String getChannel = '/api/channel/user';
  static const String wsUrl = 'http://192.168.0.195:8878';
  static const String natUrl = 'ws://192.168.0.195:8888';

  static getMsgChnlUrl(String userID)
  {
    return getChannel+"/"+userID+"/"+ChannelType.Messaging.name+"/"+"list";
  }

  
}