import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veebank/auth/login.dart';
import 'package:veebank/auth/registeration_form.dart';
import 'package:veebank/utilities/services.dart';

class Signup extends StatefulWidget {
  static const String id = 'sign_up-screen';

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return SafeArea(
      child: Scaffold(
        appBar: _services.simpleAppBar(
            title: "Create a VeeBank Account", context: context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                _services.logo(45, null),
                RegisterForm(),
                _services.sizedBox(h: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: RichText(
                        text: const TextSpan(text: '', children: [
                          TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ]),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
