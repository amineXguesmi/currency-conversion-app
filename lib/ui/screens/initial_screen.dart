import 'package:currency_conversion/core/providers/currency_provider.dart';
import 'package:currency_conversion/core/providers/user_provider.dart';
import 'package:currency_conversion/ui/screens/home_screen.dart';
import 'package:currency_conversion/ui/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  String from = "USD";
  String to = "USD";
  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            top: 20,
            child: Center(
              child: Image(
                height: 400,
                width: 420,
                image: AssetImage('assets/logo.png'),
              ),
            ),
          ),
          Positioned(
            top: 320,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
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
            top: 420,
            left: 20,
            right: 210,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomDropDown(
                  context.read<CurrencyProvider>().currencies, from, (val) {
                setState(() {
                  from = val;
                });
              }),
            ),
          ),
          Positioned(
            top: 445,
            left: 163,
            right: 190,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  String temp = from;
                  setState(() {
                    from = to;
                    to = temp;
                  });
                },
                child: const Icon(
                  Icons.swap_horiz,
                  color: Colors.deepPurple,
                  size: 35,
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 200,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomDropDown(
                  context.read<CurrencyProvider>().currencies, to, (val) {
                setState(() {
                  to = val;
                });
              }),
            ),
          ),
          Positioned(
            top: 520,
            left: 60,
            right: 60,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                onTap: () async {
                  Provider.of<UserProvider>(context, listen: false)
                      .changeSettings(userName, from, to);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("username", userName);
                  prefs.setString("defaultFrom", from);
                  prefs.setString("defaultTo", to);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                },
                child: Container(
                  height: 70,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, 0.9),
                        Color.fromRGBO(143, 148, 251, 0.2),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
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
