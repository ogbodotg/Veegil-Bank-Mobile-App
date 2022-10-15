import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veebank/auth/login.dart';
import 'package:veebank/auth/reset_password.dart';
import 'package:veebank/auth/sign_up.dart';
import 'package:veebank/pages/home_page.dart';
import 'package:veebank/pages/transactions.dart';
import 'package:veebank/provider/account_provider.dart';
import 'package:veebank/screens/main_page.dart';
import 'package:veebank/screens/splash_screen.dart';
import 'package:veebank/services/api_services/shared_services.dart';
import 'package:veebank/utilities/routes.dart';

Widget _defaultHome = LoginScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const MainScreen(
      index: 0,
    );
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'VeeBank: Your cash anywhere you go',
        theme: ThemeData(
          fontFamily: "OpenSans",
          primarySwatch: Colors.deepOrange,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // routes: Routes.route(),
        routes: {
          '/': (context) => _defaultHome,
          SplashScreen.id: (BuildContext context) => SplashScreen(),
          LoginScreen.id: (BuildContext context) => LoginScreen(),
          Signup.id: (BuildContext context) => Signup(),
          MainScreen.id: (BuildContext context) => MainScreen(),
          HomePage.id: (BuildContext context) => HomePage(),
          Transactions.id: (BuildContext context) => Transactions(),
          ResetPassword.id: (BuildContext context) => ResetPassword(),
        },
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
