import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:veebank/models/auth/login_res_model.dart';
import 'package:veebank/models/users/user_model.dart';
import 'package:veebank/pages/transactions.dart';
import 'package:veebank/provider/account_provider.dart';
import 'package:veebank/screens/main_page.dart';
import 'package:veebank/services/api_services/api_services.dart';
import 'package:veebank/services/api_services/shared_services.dart';
import 'package:veebank/utilities/services.dart';
import 'package:veebank/widget/transfer_bottom_sheet.dart';
import 'package:veebank/widget/withdraw_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = "home-page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name = '';
  int? balance = 0;
  String? accountType = '';
  String? phoneNumber;
  @override
  initState() {
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    var loginDetails = await SharedService.loginDetails();
    setState(() {
      name = loginDetails!.data.name;
      balance = loginDetails.data.balance;
      accountType = loginDetails.data.accountType;
      phoneNumber = loginDetails.data.phoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    final _accountProvider = Provider.of<AccountProvider>(context);
    _accountProvider.getBalance();
    int? _balance = 0;

    setState(() {
      _balance = _accountProvider.accountBalance;
    });

    return Scaffold(
      appBar: _services.appBar(
        title: 'Veegil Bank App',
        logout: Icons.logout_outlined,
        context: context,
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.deepOrange,
                      height: 220,
                      width: MediaQuery.of(context).size.width / .5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _services.sizedBox(h: 2),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text('Balance:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                                _services.sizedBox(w: 10),
                                Text(
                                    _services.formatPrice(
                                        amount: _balance, context: context),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.black87,
                                    )),
                              ],
                            ),
                          ),
                          _services.sizedBox(h: 15),

                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '$accountType',
                                      style: const TextStyle(
                                        // fontFamily: "Anton",
                                        letterSpacing: 3,
                                        fontSize: 18,
                                        color: Colors.black87,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '$phoneNumber',
                                      style: const TextStyle(
                                        // fontFamily: "Anton",
                                        letterSpacing: 3,
                                        fontSize: 18,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                _services.logo(
                                  40,
                                  Colors.white,
                                )
                              ],
                            ),
                          ),
                          // _services.sizedBox(h: 10),
                          Padding(
                            padding: EdgeInsets.all(14),
                            child: Text(
                              name ?? '...loading name',
                              style: const TextStyle(
                                fontFamily: "Anton",
                                letterSpacing: 3,
                                fontSize: 22,
                                color: Colors.black87,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _services.sizedBox(h: 50),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return TransferBottomSheet(
                            phoneNumber: phoneNumber!,
                            balance: balance!,
                          );
                        });
                    setState(() {});
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.send,
                        size: 60,
                        color: Colors.green,
                      ),
                      Text(
                        'Transfer',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                _services.sizedBox(w: 80),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return WithdrawBottomSheet(
                            phoneNumber: phoneNumber!,
                            balance: balance!,
                          );
                        });

                    setState(() {});
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.wallet,
                        size: 60,
                        color: Colors.redAccent,
                      ),
                      Text(
                        'Withdraw',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                )
              ]),
              _services.sizedBox(h: 25),
              Divider(thickness: 1),
              ListTile(
                leading: const Icon(
                  Icons.receipt_long,
                  size: 30,
                ),
                title: Text('My Transactions', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MainScreen(
                      index: 1,
                    );
                  }));
                },
              ),
              Divider(thickness: 1),
              ListTile(
                leading: const Icon(
                  Icons.contact_phone_outlined,
                  size: 30,
                ),
                title: Text('Contact Account Manager',
                    style: TextStyle(fontSize: 18)),
                onTap: () {},
              ),
            ],
          )),
    );
  }
}
