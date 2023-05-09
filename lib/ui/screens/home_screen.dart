import 'package:currency_conversion/ui/screens/archive_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/currency_provider.dart';
import '../../core/providers/user_provider.dart';
import '../../core/services/api_client.dart';
import '../widgets/custom_dropdown.dart';

class HomeScreen extends StatefulWidget {
  String from;
  String to;
  HomeScreen({super.key, required this.from, required this.to});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String output = "0";
  String input = "0";
  ApiClient client = ApiClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned(
            top: 10,
            child: Image(
              width: 110,
              image: AssetImage('assets/logo.png'),
            ),
          ),
          Positioned(
            top: 26,
            right: 15,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    title: const Center(
                      child: Text(
                        "Setting",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    content: SizedBox(
                      height: 200,
                      width: 280,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 240,
                            height: 60,
                            child: TextField(
                              onChanged: (value) {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .setUsername(value);
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      context.read<UserProvider>().userName,
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.purple,
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple, width: 3)),
                                  hintStyle:
                                      const TextStyle(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 240,
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 100,
                                  width: 90,
                                  color: Colors.white,
                                  child: customDropDown(
                                      context
                                          .read<CurrencyProvider>()
                                          .currencies,
                                      context.read<UserProvider>().defaultFrom,
                                      (val) {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setDefaulftFrom(val);
                                  }),
                                ),
                                const SizedBox(
                                  height: 50,
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: Colors.purple,
                                    size: 50,
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 90,
                                  color: Colors.white,
                                  child: customDropDown(
                                      context
                                          .read<CurrencyProvider>()
                                          .currencies,
                                      context.read<UserProvider>().defaultTo,
                                      (val) {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setDefaultTo(val);
                                  }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.settings,
                size: 50,
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 85,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArchiveScreen()));
              },
              child: const Icon(
                FontAwesomeIcons.database,
                size: 43,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 20,
            right: 200,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: customDropDown(
                    context.read<CurrencyProvider>().currencies, widget.from,
                    (val) {
                  setState(() {
                    widget.from = val;
                  });
                }),
              ),
            ),
          ),
          Positioned(
            top: 225,
            left: 169,
            right: 190,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  String temp = widget.from;
                  setState(() {
                    widget.from = widget.to;
                    widget.to = temp;
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
            top: 200,
            left: 200,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: customDropDown(
                    context.read<CurrencyProvider>().currencies, widget.to,
                    (val) {
                  setState(() {
                    widget.to = val;
                  });
                }),
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
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Input Amount",
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: Colors.purple,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 3)),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (value) async {
                  double rate = await client.getRate(widget.from, widget.to);
                  if (value.isEmpty) {
                    setState(() {
                      output = "0";
                    });
                  } else {
                    setState(() {
                      input = value;
                      output = (rate * (double.parse(value))).toString();
                    });
                  }
                },
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(256, 256, 256, 0.4),
                        blurRadius: 20.0,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Center(
                    child: Text(
                  output,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )),
              ),
            ),
          ),
          Positioned(
            top: 530,
            left: 60,
            right: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: GestureDetector(
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 64, 0, 0.8),
                        Color.fromRGBO(79, 212, 34, 1),
                        Color.fromRGBO(0, 64, 0, 0.8),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.save,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 590,
            left: 60,
            right: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                              from: context.read<UserProvider>().defaultFrom,
                              to: context.read<UserProvider>().defaultTo)));
                },
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(171, 7, 7, 1),
                        Color.fromRGBO(189, 63, 96, 0.9),
                        Color.fromRGBO(171, 7, 7, 1),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 45,
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
