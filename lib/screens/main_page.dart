import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veebank/pages/home_page.dart';
import 'package:veebank/pages/transactions.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({Key? key, this.index}) : super(key: key);
  static const String id = "main-page";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Transactions(),
    HomePage(),
    HomePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index!;
      });
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final _cartProvider = Provider.of<CartProvider>(context);
    // final _customerData = Provider.of<CustomerProvider>(context);

    // _cartProvider.getCartTotal();
    // _customerData.getCustomerData();

    // cartModel = _cartProvider.cartModel;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
        child: BottomNavigationBar(
          elevation: 4,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                  Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 1 ? Icons.payment : Icons.payment_outlined),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2
                  ? Icons.account_balance
                  : Icons.account_balance_outlined),
              label: 'Accounts',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3 ? Icons.money : Icons.money),
              label: 'Investments & Loans',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black54,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.shifting,
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
