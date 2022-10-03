class RegisterReqModel {
  RegisterReqModel({
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.email,
    required this.accountType,
    required this.balance,
  });
  late final String name;
  late final String phoneNumber;
  late final String password;
  late final String email;
  late final String accountType;
  late final double balance;

  RegisterReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    email = json['email'];
    accountType = json['accountType'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['phoneNumber'] = phoneNumber;
    _data['password'] = password;
    _data['email'] = email;
    _data['accountType'] = accountType;
    _data['balance'] = balance;

    return _data;
  }
}
