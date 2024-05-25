import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class UserModel extends Equatable {
  final String? uId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? imgUrl;
  final String? password;
  final bool? isAdmin;

  const UserModel({
    this.uId,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.imgUrl,
    this.password,
    this.isAdmin,
  });

  UserModel copyWith({
    String? uId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imgUrl,
    String? password,
    bool? isAdmin,
  }) {
    return UserModel(
      uId: uId ?? this.uId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imgUrl: imgUrl ?? this.imgUrl,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'imgUrl': imgUrl,
      'password': password,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromSnap(DocumentSnapshot snapshot) {
    return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uId: map['uId'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      imgUrl: map['imgUrl'],
      password: map['password'],
      isAdmin: map['isAdmin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        uId,
        firstName,
        lastName,
        email,
        phone,
        imgUrl,
        password,
        isAdmin,
      ];

  @override
  bool get stringify => true;
}
