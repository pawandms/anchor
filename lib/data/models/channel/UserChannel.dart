import 'package:equatable/equatable.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../core/utils/Helper.dart';
import '../../enums/UserRoleType.dart';
import '../media/MediaImage.dart';
import '../message/ApiMessage.dart';
import 'ChnlParticipents.dart';

class UserChannel  {

  late String chnlId;
  late String name;
  late Rx<ApiMessage>? msg;
  late DateTime? msgDate;
  late List<UserRoleType> userRoles;
  late MediaImage? chnLogo;
  late Rx<int> unreadCount;
  late bool active;
  late List<ChnlParticipent> users = [];
  int page = 0;
  int itemPerPage = 10;
  bool getFirstData = false;
  bool lastPage = false;
  late RxList<ApiMessage> messages = RxList<ApiMessage>();
  bool msgLoadedFlag = false;
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
      msg: map['msg'] == null ? null : Rx(ApiMessage.fromMap(map['msg'])),
      msgDate: map['msgDate'] == null ? null : Helper.getLocalDateFromUtcDateString(map['msgDate']) ,
      userRoles: List.of(map["userRoles"])
          .map((i) => UserRoleTypeExtension.getType(i)).toList(),
      chnLogo: map['chnLogo'] == null ? null : MediaImage.fromMap(map['chnLogo']),
      unreadCount: RxInt(map['unreadCount'] as int),
      active: map['active'] as bool,
      users: List.of(map["chnlUsers"])
          .map((i) => ChnlParticipent.fromMap(i))
          .toList(),

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
    required this.users,
  });

}