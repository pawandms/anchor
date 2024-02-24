
import 'package:anchor_getx/data/models/BaseVo.dart';
import 'package:anchor_getx/data/models/media/MediaImage.dart';
import 'package:anchor_getx/data/models/user/User.dart';

class Channel {
  String id;
  String? type;
  String? visibility;
  String? subscriptionType;
  String? name;
  String? description;
  String? encriptedName;
  List<MediaImage>? imageList;
  bool? active;
  String? createdBy;
  DateTime? createdOn;
  String? modifiedBy;
  DateTime? modifiedOn;
  List<String>? userRoles;
  DateTime? validFrom;
  DateTime? validTo;
  List<User>? chnlUsers;
  String? latestMsgId;
  DateTime? latestMsgDate;


  Channel({
      required this.id,
      this.type,
      this.visibility,
      this.subscriptionType,
      this.name,
      this.description,
      this.encriptedName,
      this.imageList,
      this.active,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.userRoles,
      this.validFrom,
      this.validTo,
      this.chnlUsers,
      this.latestMsgId,
      this.latestMsgDate});

  @override
  String toString() {
    return 'Channel{id: $id, type: $type, visibility: $visibility, subscriptionType: $subscriptionType, name: $name, description: $description, encriptedName: $encriptedName, imageList: $imageList, active: $active, createdBy: $createdBy, createdOn: $createdOn, modifiedBy: $modifiedBy, modifiedOn: $modifiedOn, userRoles: $userRoles, validFrom: $validFrom, validTo: $validTo, chnlUsers: $chnlUsers, latestMsgId: $latestMsgId, latestMsgDate: $latestMsgDate}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'type': this.type,
      'visibility': this.visibility,
      'subscriptionType': this.subscriptionType,
      'name': this.name,
      'description': this.description,
      'encriptedName': this.encriptedName,
      'imageList': this.imageList,
      'active': this.active,
      'createdBy': this.createdBy,
      'createdOn': this.createdOn,
      'modifiedBy': this.modifiedBy,
      'modifiedOn': this.modifiedOn,
      'userRoles': this.userRoles,
      'validFrom': this.validFrom,
      'validTo': this.validTo,
      'chnlUsers': this.chnlUsers,
      'latestMsgId': this.latestMsgId,
      'latestMsgDate': this.latestMsgDate,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
   final id=  map['id'];
    final type =  map['type'] ;
    final visibility =  map['visibility'] ;
    final subscriptionType =  map['subscriptionType'] ;
    final name=  map['name'] ;
    final description =  map['description'] ;
    final encriptedName=  map['encriptedName'] ;
    final imageList = List.of(map["imageList"])
        .map((i) => MediaImage.fromMap(i) /* can't generate it properly yet */)
        .toList();
    final active=  map['active'] as bool;
    final createdBy=  map['createdBy'];
    final createdOn=  map['createdOn'] == null ? null : DateTime.parse(map['createdOn']);
    final modifiedBy =  map['modifiedBy'];
    final modifiedOn = map['modifiedOn'] == null ? null : DateTime.parse(map['modifiedOn']);
    final  List<String>? userRoles =  map['userRoles'] != null ? List.from(map['userRoles']) : null;
    final validFrom =  map['validFrom'] == null ? null : DateTime.parse(map['validFrom']);
    final validTo= map['validTo'] == null ? null : DateTime.parse(map['validTo']);
    final List<User>chnlUsers = List.of(map["chnlUsers"])
        .map((i) => User.fromMap(i) /* can't generate it properly yet */)
        .toList();
    final latestMsgId=  map['latestMsgId'] ;
    final latestMsgDate = map['latestMsgDate'] == null ? null : DateTime.parse(map['latestMsgDate']);

    return Channel(
      id: id,
      type: type,
      visibility: visibility,
      subscriptionType: subscriptionType,
      name: name,
      description: description,
      encriptedName: encriptedName,
      imageList: imageList,
      active: active,
      createdBy: createdBy,
      createdOn: createdOn,
      modifiedBy: modifiedBy,
      modifiedOn: modifiedOn,
      userRoles: userRoles,
      validFrom: validFrom,
      validTo: validTo,
      chnlUsers: chnlUsers,
      latestMsgId: latestMsgId,
      latestMsgDate: latestMsgDate,
    );


  }
//
}