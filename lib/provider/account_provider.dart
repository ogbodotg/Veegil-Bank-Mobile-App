import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:veebank/models/users/user_model.dart';
import 'package:veebank/services/api_services/shared_services.dart';
import 'package:veebank/utilities/config.dart';
import 'package:http/http.dart' as http;

class AccountProvider with ChangeNotifier {
  int accountBalance = 0;
  static var client = http.Client();

  getBalance() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}'
    };

    var accountBalanceURL =
        "${Config.accountBalanceAPI}/${loginDetails.data.phoneNumber}";

    var url = Uri.http(Config.apiURL, accountBalanceURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      this.accountBalance = data;

      notifyListeners();

      // return usersFromJson(data["balance"]);
    } else {
      return null;
    }
  }
}
