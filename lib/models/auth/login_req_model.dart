import 'package:flutter/material.dart';

class LoginReqModel {
  LoginReqModel({
    required this.phoneNumber,
    required this.password,
  });
  late final String phoneNumber;
  late final String password;

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phoneNumber'] = phoneNumber;
    _data['password'] = password;
    return _data;
  }
}
