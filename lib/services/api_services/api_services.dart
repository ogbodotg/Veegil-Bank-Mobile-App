import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:veebank/models/auth/login_req_model.dart';
import 'package:veebank/models/auth/login_res_model.dart';
import 'package:veebank/models/auth/register_req_model.dart';
import 'package:veebank/models/auth/register_res_model.dart';
import 'package:veebank/models/transactions/transaction_model.dart';
import 'package:veebank/models/users/user_model.dart';
import 'package:veebank/pages/home_page.dart';
import 'package:veebank/services/api_services/shared_services.dart';
import 'package:veebank/utilities/config.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(
    LoginReqModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.loginAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> signup(
    RegisterReqModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.signupAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<bool> transfer(TransactionModel model) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}'
    };

    var url = Uri.http(
      Config.apiURL,
      Config.transferAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> withdraw(TransactionModel model) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}'
    };

    var url = Uri.http(
      Config.apiURL,
      Config.withdrawAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<TransactionModel>?> getTransactions() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}'
    };

    var singleTransactionURL =
        "${Config.singleTransactionAPI}/${loginDetails.data.phoneNumber}";

    var url = Uri.http(
      Config.apiURL,
      singleTransactionURL,
    );

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return transactionsFromJson(data["transaction"]);
    } else {
      return null;
    }
  }

  static Future<List<UserModel>?> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var userURL = Config.userProfileAPI + "/" + loginDetails.data.phoneNumber;

    var url = Uri.http(Config.apiURL, userURL);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return usersFromJson(data["data"]);
    } else {
      return null;
    }
  }
}
