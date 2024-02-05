import 'package:anchor_getx/presentation/log_in_screen/models/user.dart';
import 'package:loggy/loggy.dart';

class LoginResponseModel {
  String? access_token;
  String? refresh_token;
  String? token_type;
  int? expires_in;
  User? user;
  String error = 'NA';
  String error_description = 'NA';
  bool valid = false;

  LoginResponseModel({
    this.access_token,
    this.refresh_token,
    this.token_type,
    this.expires_in,
    this.user,
    this.error = 'NA',
    this.error_description = 'NA',
  });

  Map<String, dynamic> toMap() {
    return {
      'access_token': this.access_token,
      'refresh_token': this.refresh_token,
      'token_type': this.token_type,
      'expires_in': this.expires_in,
      'user': this.user,
      'error': this.error,
      'error_description': this.error_description,
    };
  }

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    LoginResponseModel resp =
     LoginResponseModel(
      access_token: map['access_token'],
      refresh_token: map['refresh_token'],
      token_type: map['token_type'],
      expires_in: map['expires_in'],
      user: map['user'] == null ? null : User.fromMap(map['user']),
      error: map['error'] == null ? 'NA': map['error']  ,
      error_description: map['error_description'] == null ? 'NA' : map['error_description'],
    );
    if((null != resp.access_token) && (null != resp.refresh_token))
    {
      resp.valid = true;
    }
    return resp;

    /* LoginResponseModel resp = new LoginResponseModel();
    try{
      resp.access_token = map['access_token'] == null ? null : map['access_token'] as String;
      resp.refresh_token = map['refresh_token'] == null ? null : map['refresh_token'] as String;
      resp.token_type= map['token_type'] == null ? null : map['token_type'] as String;
      resp.expires_in = map['expires_in'] == null ? 0 : map['expires_in'] as int;
      resp.user = map['user'] == null ? null : User.fromMap(map['user']);
      resp.error= map['error']== null ? null : map['error'] as String;
      resp.error_description = map['error_description'] == null ? null : map['error_description'] as String;

    }
    catch(e)
    {
      logError("Conversion Error:$e");
    }
    return LoginResponseModel(
      access_token: map['access_token'] == null ? null : map['access_token'] as String,
      refresh_token: map['refresh_token'] == null ? null : map['refresh_token'] as String,
      token_type: map['token_type'] as String,
      expires_in: map['expires_in'] == null ? 0 : map['expires_in'] as int,
      user: map['user'] == null ? null : User.fromMap(map['user']),
      error: map['error']== null ? null : map['error'] as String,
      error_description: map['error_description'] == null ? null : map['error_description'] as String,
    );

    */


  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": this.access_token,
      "refresh_token": this.refresh_token,
      "token_type": this.token_type,
      "expires_in": this.expires_in,
     // "user": this.user,
      "error": this.error,
      "error_description": this.error_description,
      "valid": this.valid,
    };
  }

/*
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {

    LoginResponseModel response = new LoginResponseModel();

    try{
      if(json.containsKey('access_token'))
      {
        response.access_token = json['access_token'];

      }
      return LoginResponseModel(
        access_token: json['access_token'] ,
        refresh_token: json['refresh_token'],
        token_type: json['token_type'],
        expires_in: json['expires_in'] == null ? null :int.parse(json['expires_in']) ,
        user: User.fromJson(json['user']),
        error: json['error'],
        error_description: json['error_description'],
      );
    }
    catch(e)
    {
      logError("Conversion Error:$e");
    }
    return response;
  }

   */


//
}
