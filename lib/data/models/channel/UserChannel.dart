import '../../enums/UserRoleType.dart';
import '../media/MediaImage.dart';
import '../message/Message.dart';

class UserChannel  {

  late String chnlId;
  late String name;
  late Message? msg;
  late DateTime? msgDate;
  late List<UserRoleType> userRoles;
  late MediaImage? chnLogo;
  late int unreadCount;
  late bool active;



  Map<String, dynamic> toMap() {
    return {
      'chnlId': this.chnlId,
      'name': this.name,
      'msg': this.msg,
      'msgDate': this.msgDate,
      'userRoles': this.userRoles,
      'chnLogo': this.chnLogo,
      'unreadCount': this.unreadCount,
      'active': this.active,
    };
  }

  factory UserChannel.fromMap(Map<String, dynamic> map) {
    return UserChannel(
      chnlId: map['chnlId'] as String,
      name: map['name'] as String,
      msg: map['msg'] == null ? null : Message.fromMap(map['msg']),
      msgDate: map['msgDate'] == null ? null : DateTime.parse(map['msgDate']),
      userRoles: List.of(map["userRoles"])
          .map((i) => UserRoleTypeExtension.getType(i)).toList(),
      chnLogo: map['chnLogo'] == null ? null : MediaImage.fromMap(map['chnLogo']),
      unreadCount: map['unreadCount'] as int,
      active: map['active'] as bool,
    );
  }

  UserChannel({
    required this.chnlId,
    required this.name,
    this.msg,
    this.msgDate,
    required this.userRoles,
    this.chnLogo,
    required this.unreadCount,
    required this.active,
  });


}