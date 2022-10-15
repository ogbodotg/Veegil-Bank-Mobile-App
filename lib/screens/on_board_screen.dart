import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veebank/auth/login.dart';
import 'package:veebank/screens/main_page.dart';
import 'package:veebank/utilities/services.dart';
// import 'package:get_storage/get_storage.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);
  static const String id = "on-board-screen";

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  double scrollerPosition = 0;
  // final storeDevice = GetStorage();

  onSkipClick(context) async {
    final prefs = await SharedPreferences.getInstance();

    // store device on click
    // storeDevice.write("onBoard", true);
    await prefs.setBool('onBoard', true);
    return Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              onPageChanged: (val) {
                setState(() {
                  scrollerPosition = val.toDouble();
                });
              },
              // scrollDirection: Axis.horizontal,
              children: [
                OnBoardPageChange(
                    onBoardImage: Image.asset(
                      "assets/images/goldcard.jpeg",
                      fit: BoxFit.cover,
                    ),
                    onBoardText: Text(
                        "Make local & international payments without limits",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ))),
                OnBoardPageChange(
                    onBoardImage: Image.asset(
                      "assets/images/globe.png",
                      fit: BoxFit.cover,
                    ),
                    onBoardText: Text("Bank from anywhere on planet earth",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ))),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DotsIndicator(
                    dotsCount: 2,
                    position: scrollerPosition,
                    decorator: DotsDecorator(activeColor: Colors.white),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: const Text("SKIP",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        )),
                    onPressed: () {
                      onSkipClick(context);
                    },
                  ),
                  _services.sizedBox(h: 20)
                ],
              ),
            ),
          ],
        ));
  }
}

class OnBoardPageChange extends StatelessWidget {
  const OnBoardPageChange({
    Key? key,
    required this.onBoardImage,
    required this.onBoardText,
  }) : super(key: key);
  final Image onBoardImage;
  final Text onBoardText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 400,
                width: 400,
                child: onBoardImage,
              ),
              onBoardText
            ],
          )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
          ),
        ),
      ],
    );
  }
}
