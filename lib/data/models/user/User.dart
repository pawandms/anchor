
import '../../../core/utils/Helper.dart';

class User {
  String? id;
  String? uid;
  String? userName;
  String? nickName;
  bool? admin;
  String? gender;
  int? birthday;
  String? signature;
  String? email;
  int? emailBindTime;
  String? mobile;
  int? mobileBindTime;
  String? face;
  String? face200;
  String? srcface;
  int? status;
  String? firstName;
  String? lastName;
  String? createdBy;
  String? createdDate;
  String? modifiedBy;
  String? modifiedDate;
  int? type;



  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uid': this.uid,
      'userName': this.userName,
      'nickName': this.nickName,
      'admin': this.admin,
      'gender': this.gender,
      'birthday': this.birthday,
      'signature': this.signature,
      'email': this.email,
      'emailBindTime': this.emailBindTime,
      'mobile': this.mobile,
      'mobileBindTime': this.mobileBindTime,
      'face': this.face,
      'face200': this.face200,
      'srcface': this.srcface,
      'status': this.status,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'createdBy': this.createdBy,
      'createdDate': this.createdDate,
      'modifiedBy': this.modifiedBy,
      'modifiedDate': this.modifiedDate,
      'type': this.type,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      uid: map['uid'],
      userName: map['userName'],
      nickName: map['nickName'],
      admin: map['admin'],
      gender: map['gender'],
      birthday: map['birthday'],
      signature: map['signature'],
      email: map['email'],
      emailBindTime: map['emailBindTime'],
      mobile: map['mobile'],
      mobileBindTime: map['mobileBindTime'],
      face: map['face'],
      face200: map['face200'],
      srcface: map['srcface'],
      status: map['status'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      createdBy: map['createdBy'],
      createdDate: map['createdDate'],
      modifiedBy: map['modifiedBy'],
      modifiedDate: map['modifiedDate'],
      type: map['type'],
    );
  }

  User({
    this.id,
    this.uid,
    this.userName,
    this.nickName,
    this.admin,
    this.gender,
    this.birthday,
    this.signature,
    this.email,
    this.emailBindTime,
    this.mobile,
    this.mobileBindTime,
    this.face,
    this.face200,
    this.srcface,
    this.status,
    this.firstName,
    this.lastName,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.type,
  }); //
}