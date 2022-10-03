import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.phoneNumber,
    required this.email,
    required this.name,
    required this.id,
    required this.token,
    required this.balance,
  });
  late final String phoneNumber;
  late final String email;
  late final String name;
  late final String id;
  late final String token;
  late final int balance;

  late final String accountType;

  Data.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    name = json['name'];
    id = json['id'];
    token = json['token'];
    balance = json['balance'];
    accountType = json['accountType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['phoneNumber'] = phoneNumber;
    _data['email'] = email;
    _data['name'] = name;
    _data['id'] = id;
    _data['token'] = token;
    _data['balance'] = balance;
    _data['accountType'] = accountType;

    return _data;
  }
}
