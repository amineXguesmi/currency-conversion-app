import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/services/api_client.dart';
import '../widgets/custom_dropdown.dart';

class HomeScreen extends StatefulWidget {
  final List<String> currencies;
  String from;
  String to;
  HomeScreen(
      {super.key,
      required this.currencies,
      required this.from,
      required this.to});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String output = "0";
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
                    builder: (context) => const AlertDialog(
                          title: Text(
                            "Setting",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ));
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
              onTap: () {},
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
                child: customDropDown(widget.currencies, widget.from, (val) {
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
                child: Container(
                  child: const Icon(
                    Icons.swap_horiz,
                    color: Colors.deepPurple,
                    size: 35,
                  ),
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
                child: customDropDown(widget.currencies, widget.to, (val) {
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
              child: Container(
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
                        output = (rate * (double.parse(value))).toString();
                      });
                    }
                  },
                ),
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
                  style: TextStyle(
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
