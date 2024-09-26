
import '../../enums/GenderType.dart';
import '../../enums/UserProfileType.dart';
import '../media/MediaImage.dart';

class SearchUser{
  String userID;
  String firstName;
  String lastName;
  GenderType gender;
  MediaImage? profileImage;
  UserProfileType profileType;
  DateTime? lastLogin;
  bool active;

  SearchUser({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.profileImage,
    required this.profileType,
    this.lastLogin,
    required this.active

});

  Map<String, dynamic> toMap() {
    return {
      'userID': this.userID,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'gender': this.gender,
      'profileImage': this.profileImage,
      'profileType': this.profileType,
      'lastLogin': this.lastLogin,
      'active': this.active,
    };
  }

  factory SearchUser.fromMap(Map<String, dynamic> map) {
    return SearchUser(
      userID: map['userID'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      gender: GenderTypeExtension.getType(map['gender']),
      profileImage: map['profileImage'] as MediaImage,
      profileType: UserProfileTypeExtension.getType(map['profileType']),
      lastLogin: map['lastLogin'] == null ? null : DateTime.parse(map['lastLogin']),
      active: map['active'] as bool,
    );
  }
}