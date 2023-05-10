import 'dart:async';

import 'package:currency_conversion/core/providers/currency_provider.dart';
import 'package:currency_conversion/core/providers/user_provider.dart';
import 'package:currency_conversion/ui/screens/home_screen.dart';
import 'package:currency_conversion/ui/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/media_query.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String from = "USD";
  String to = "USD";
  String userName = "";
  bool animate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      animate = false;
    });
    Timer(
        const Duration(milliseconds: 600),
        () => setState(() {
              animate = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media =
        Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: media.getHeight(20),
            child: Center(
              child: Image(
                height: media.getHeight(400),
                width: media.getWidht(420),
                image: const AssetImage('assets/logo.png'),
              ),
            ),
          ),
          Positioned(
            top: media.getHeight(320),
            left: media.getWidht(20),
            right: media.getWidht(20),
            child: Padding(
              padding: EdgeInsets.all(media.getWidht(20.0)),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    userName = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "UserName",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.purple,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 3)),
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
          ),
          Positioned(
            top: media.getHeight(420),
            left: media.getWidht(20),
            right: media.getWidht(210),
            child: Padding(
              padding: EdgeInsets.all(media.getWidht(20)),
              child: CustomDropDown(
                  context.read<CurrencyProvider>().currencies, from, (val) {
                setState(() {
                  from = val;
                });
              }),
            ),
          ),
          Positioned(
            top: media.getHeight(445),
            left: media.getWidht(163),
            right: media.getWidht(190),
            child: Padding(
              padding: EdgeInsets.all(media.getWidht(10)),
              child: GestureDetector(
                onTap: () {
                  String temp = from;
                  setState(() {
                    from = to;
                    to = temp;
                  });
                },
                child: Icon(
                  Icons.swap_horiz,
                  color: Colors.deepPurple,
                  size: media.getWidht(35),
                ),
              ),
            ),
          ),
          Positioned(
            top: media.getHeight(420),
            left: media.getWidht(200),
            right: media.getWidht(20),
            child: Padding(
              padding: EdgeInsets.all(media.getWidht(20)),
              child: CustomDropDown(
                  context.read<CurrencyProvider>().currencies, to, (val) {
                setState(() {
                  to = val;
                });
              }),
            ),
          ),
          Positioned(
            top: media.getHeight(520),
            left: media.getWidht(60),
            right: media.getWidht(60),
            child: Padding(
              padding: EdgeInsets.all(media.getWidht(20.0)),
              child: GestureDetector(
                onTap: () async {
                  if (userName != "") {
                    FocusScope.of(context).unfocus();
                    Provider.of<UserProvider>(context, listen: false)
                        .changeSettings(userName, from, to);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("username", userName);
                    prefs.setString("defaultFrom", from);
                    prefs.setString("defaultTo", to);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          "UserName is empty",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: media.getWidht(22),
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: animate ? 1 : 0,
                  curve: Curves.easeOutSine,
                  child: Container(
                    height: media.getHeight(70),
                    width: media.getWidht(50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(media.getWidht(10)),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, 0.9),
                          Color.fromRGBO(143, 148, 251, 0.2),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: media.getWidht(19)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
