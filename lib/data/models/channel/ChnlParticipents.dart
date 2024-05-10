
import '../../enums/ChannelType.dart';
import '../../enums/GenderType.dart';
import '../../enums/UserRoleType.dart';
import '../media/MediaImage.dart';

class ChnlParticipent{
  late String channelID;
  late ChannelType channelType;
  late String userID;
  late String firstName;
  late String lastName;
  late GenderType gender;
  late MediaImage? profileImage;
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
    this.profileImage,
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
      'profileImage': this.profileImage,
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
      profileImage: map['profileImage'] == null ? null : MediaImage.fromMap(map['profileImage']),
      active: map['active'] as bool,
      userRoles:  List.of(map["userRoles"])
          .map((i) => UserRoleTypeExtension.getType(i)).toList(),
      validFrom: map['validFrom'] == null ? DateTime.now() : DateTime.parse(map['validFrom']),
      validTo: map['validTo'] == null ? DateTime.now() : DateTime.parse(map['validTo']),
    );
  }
}