// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? id;
  String? uid;
  String? userName;
  String? nickName;
  bool? admin;
  String? gender;
  String? email;
  int? status;
  String? firstName;
  String? lastName;
  int? type;



  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uid': this.uid,
      'userName': this.userName,
      'nickName': this.nickName,
      'admin': this.admin,
      'gender': this.gender,
      'email': this.email,
      'status': this.status,
      'firstName': this.firstName,
      'lastName': this.lastName,
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
      email: map['email'],
      status: map['status'],
      firstName: map['firstName'],
      lastName: map['lastName'],
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
    this.email,
    this.status,
    this.firstName,
    this.lastName,
    this.type,
  });
}
