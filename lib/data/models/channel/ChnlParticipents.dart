
import '../../enums/ChannelType.dart';
import '../../enums/GenderType.dart';
import '../../enums/UserRoleType.dart';

class ChnlParticipent{
  late String channelID;
  late ChannelType channelType;
  late String userID;
  late String firstName;
  late String lastName;
  late GenderType gender;
  late String faceUrl;
  late bool active;
  late List<UserRoleType> userRoles = [];
  late DateTime validFrom;
  late DateTime validTo;

  ChnlParticipent({
    required this.channelID,
    required this.channelType,
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.faceUrl,
    required this.active,
    required this.userRoles,
    required this.validFrom,
    required this.validTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'channelID': this.channelID,
      'channelType': this.channelType,
      'userID': this.userID,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'faceUrl': this.faceUrl,
      'active': this.active,
      'userRoles': this.userRoles,
      'validFrom': this.validFrom,
      'validTo': this.validTo,
    };
  }

  factory ChnlParticipent.fromMap(Map<String, dynamic> map) {
    return ChnlParticipent(
      channelID: map['channelID'] as String,
      channelType: ChannelTypeExtension.getType(map['channelType']),
      userID: map['userID'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      gender: GenderTypeExtension.getType(map['gender']),
      faceUrl: map['faceUrl'] == null ? '' : map['faceUrl'] as String,
      active: map['active'] as bool,
      userRoles:  List.of(map["userRoles"])
          .map((i) => UserRoleTypeExtension.getType(i)).toList(),
      validFrom: map['validFrom'] == null ? DateTime.now() : DateTime.parse(map['validFrom']),
      validTo: map['validTo'] == null ? DateTime.now() : DateTime.parse(map['validTo']),
    );
  }
}