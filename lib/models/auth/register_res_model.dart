import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });
  late final String? message;
  late final Data? data;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.accountType,
    required this.balance,
    required this.id,
  });
  late final String email;
  late final String name;
  late final String phoneNumber;
  late final String accountType;
  late final int balance;
  late final String id;

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    balance = json['balance'];
    accountType = json['accountType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['phoneNumber'] = phoneNumber;
    _data['balance'] = balance;
    _data['accountType'] = accountType;
    _data['email'] = email;
    _data['id'] = id;
    return _data;
  }
}
