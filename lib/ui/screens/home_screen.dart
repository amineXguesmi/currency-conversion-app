import 'package:currency_conversion/core/models/conversion.dart';
import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:currency_conversion/ui/screens/archive_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/currency_provider.dart';
import '../../core/providers/user_provider.dart';
import '../../core/services/api_client.dart';
import '../widgets/custom_dropdown.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String output = "0";
  String input = "0";
  ApiClient client = ApiClient();
  final TextEditingController inputController =
      TextEditingController(text: "0");
  final TextEditingController outputController =
      TextEditingController(text: "0");

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  void convertInputToOutput(from, to) async {
    double rate = await client.getRate(from, to);
    double inputValue = double.tryParse(inputController.text) ?? 0;
    double outputValue = rate * inputValue;
    setState(() {
      output = outputValue.toString();
      outputController.text = output;
    });
  }

  void convertOutputToInput(from, to) async {
    double rate = await client.getRate(to, from);
    double outputValue = double.tryParse(outputController.text) ?? 0;
    double inputValue = rate * outputValue;
    setState(() {
      input = inputValue.toString();
      inputController.text = input;
    });
  }

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
                                  child: CustomDropDown(
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
                                  child: CustomDropDown(
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
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0, 0.7, 1],
                    colors: [
                      Color(0xFF49125c),
                      Color(0xFf3b246a),
                      Color(0xFF926b9f),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  context.watch<UserProvider>().defaultFrom,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                )),
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: 159,
            right: 190,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false)
                      .swipeDefault();
                  convertInputToOutput(context.read<UserProvider>().defaultFrom,
                      context.read<UserProvider>().defaultTo);
                },
                child: const Icon(
                  Icons.swap_horiz,
                  color: Colors.deepPurple,
                  size: 55,
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
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0, 0.7, 1],
                    colors: [
                      Color(0xFF49125c),
                      Color(0xFf3b246a),
                      Color(0xFF926b9f),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  context.watch<UserProvider>().defaultTo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                )),
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
                controller: inputController,
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
                onChanged: (value) {
                  convertInputToOutput(context.read<UserProvider>().defaultFrom,
                      context.read<UserProvider>().defaultTo);
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
              child: TextField(
                controller: outputController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Output Amount",
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: Colors.purple,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 3)),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  convertOutputToInput(context.read<UserProvider>().defaultFrom,
                      context.read<UserProvider>().defaultTo);
                },
              ),
            ),
          ),
          Positioned(
            top: 650,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  DateTime now = DateTime.now();
                  int year = now.year;
                  int month = now.month;
                  int day = now.day;
                  String date = '$day/$month/$year';
                  int hour = now.hour;
                  int minute = now.minute;
                  int second = now.second;
                  String time = '$hour:$minute:$second';
                  String conversionFrom =
                      '$input:${context.watch<UserProvider>().defaultFrom}';
                  String conversionTo =
                      '$output:${context.watch<UserProvider>().defaultTo}';
                  Conversion conversion = Conversion(
                      date: date,
                      time: time,
                      conversionFrom: conversionFrom,
                      conversionTo: conversionTo);
                  Provider.of<ArchiveProvier>(context, listen: false)
                      .AddConversion(conversion);
                },
                child: Container(
                  height: 60,
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
            top: 730,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  height: 60,
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
