import 'dart:async';

import 'package:currency_conversion/core/models/conversion.dart';
import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:currency_conversion/core/providers/rate_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/providers/user_provider.dart';
import '../../core/services/api_client.dart';
import '../utilities/media_query.dart';
import '../widgets/navbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String output = "0";
  String input = "0";
  bool animate = false;
  String error = "";
  ApiClient client = ApiClient();
  final TextEditingController inputController =
      TextEditingController(text: null);
  final TextEditingController outputController =
      TextEditingController(text: null);

  @override
  void initState() {
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
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  void convertInputToOutput(from, to) async {
    try {
      double rate = context.read<RateProvider>().rate;
      double inputValue = double.tryParse(inputController.text) ?? 0;
      input = inputController.text;
      double outputValue = rate * inputValue;
      setState(() {
        output = outputValue.toString();
        outputController.text = output;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media =
        Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            const NavBar(),
            Positioned(
              top: media.getHeight(200),
              left: media.getWidht(20),
              right: media.getWidht(210),
              child: Padding(
                padding: EdgeInsets.all(media.getWidht(20)),
                child: Container(
                  height: media.getHeight(50),
                  width: media.getWidht(50),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(70, 106, 148, 1),
                    borderRadius: BorderRadius.circular(media.getWidht(10)),
                  ),
                  child: Center(
                      child: Text(
                    context.watch<UserProvider>().defaultFrom,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: media.getWidht(25),
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
            Positioned(
              top: media.getHeight(195),
              left: media.getWidht(147),
              right: media.getWidht(190),
              child: GestureDetector(
                onTap: () {
                  try {
                    FocusScope.of(context).unfocus();
                    Provider.of<UserProvider>(context, listen: false)
                        .swipeDefault();
                    Provider.of<RateProvider>(context, listen: false).fetchRate(
                        context.read<UserProvider>().defaultFrom,
                        context.read<UserProvider>().defaultTo);
                    convertInputToOutput(
                        context.read<UserProvider>().defaultFrom,
                        context.read<UserProvider>().defaultTo);
                  } catch (e) {
                    if (e.toString() ==
                        "Exception: Error occurred while fetching api , please try again later") {
                      setState(() {
                        error =
                            "Error occurred while fetching api , please try again later";
                      });
                    }
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: const Center(
                              child: Text(
                                "Oppsss",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 40),
                              ),
                            ),
                            content: SizedBox(
                              height: 140,
                              width: 200,
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.dangerous,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    error,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(media.getWidht(10)),
                  child: Icon(
                    Icons.swap_horiz,
                    color: Colors.deepPurple,
                    size: media.getWidht(80),
                  ),
                ),
              ),
            ),
            Positioned(
              top: media.getHeight(200),
              left: media.getWidht(210),
              right: media.getWidht(20),
              child: Padding(
                padding: EdgeInsets.all(media.getWidht(20)),
                child: Container(
                  height: media.getHeight(50),
                  width: media.getWidht(50),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(70, 106, 148, 1),
                    borderRadius: BorderRadius.circular(media.getWidht(10)),
                  ),
                  child: Center(
                      child: Text(
                    context.watch<UserProvider>().defaultTo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: media.getWidht(25),
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
            Positioned(
              top: media.getHeight(320),
              left: media.getWidht(20),
              right: media.getWidht(20),
              child: Padding(
                padding: EdgeInsets.all(media.getWidht(20)),
                child: TextField(
                  controller: inputController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Input Amount",
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: Colors.purple,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepPurple,
                            width: media.getWidht(3))),
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                  onChanged: (value) {
                    try {
                      convertInputToOutput(
                          context.read<UserProvider>().defaultFrom,
                          context.read<UserProvider>().defaultTo);
                    } catch (e) {
                      if (e.toString() ==
                          "Exception: Error occurred while fetching api , please try again later") {
                        setState(() {
                          error =
                              "Error occurred while fetching api , please try again later";
                        });
                      }
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Center(
                                child: Text(
                                  "Opppsss",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                ),
                              ),
                              content: SizedBox(
                                height: 140,
                                width: 200,
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.dangerous,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      error,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )));
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+\.?\d*)?')),
                  ],
                ),
              ),
            ),
            Positioned(
              top: media.getHeight(420),
              left: media.getWidht(50),
              right: media.getWidht(50),
              child: Padding(
                padding: EdgeInsets.all(media.getWidht(20)),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: outputController,
                  enabled: false,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(70, 106, 148, 1),
                    border: const OutlineInputBorder(),
                    hintText: "Output Amount",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.deepPurple,
                            width: media.getWidht(3))),
                    hintStyle: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            Positioned(
              top: media.getHeight(650),
              left: media.getWidht(20),
              right: media.getWidht(20),
              child: Padding(
                padding: EdgeInsets.only(
                    left: media.getWidht(10), right: media.getWidht(10)),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
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
                        '$input:${context.read<UserProvider>().defaultFrom}';
                    String conversionTo =
                        '$output:${context.read<UserProvider>().defaultTo}';
                    Conversion conversion = Conversion(
                        date: date,
                        time: time,
                        conversionFrom: conversionFrom,
                        conversionTo: conversionTo);
                    Provider.of<ArchiveProvider>(context, listen: false)
                        .addConversion(conversion);
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: const Center(
                              child: Text(
                                "Success",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.green),
                              ),
                            ),
                            content: SizedBox(
                              height: 180,
                              width: 200,
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    "Your Conversion Added Successfully to your archive ,feel free to check it ",
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )));
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: animate ? 1 : 0,
                    curve: Curves.easeOutSine,
                    child: Container(
                      height: media.getHeight(60),
                      width: media.getWidht(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(media.getWidht(10)),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(0, 64, 0, 0.8),
                            Color.fromRGBO(79, 212, 34, 1),
                            Color.fromRGBO(0, 64, 0, 0.8),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.save,
                          color: Colors.white,
                          size: media.getWidht(45),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: media.getHeight(730),
              left: media.getWidht(20),
              right: media.getWidht(20),
              child: Padding(
                padding: EdgeInsets.only(
                    left: media.getWidht(10), right: media.getWidht(10)),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 600),
                    opacity: animate ? 1 : 0,
                    curve: Curves.easeOutSine,
                    child: Container(
                      height: media.getHeight(60),
                      width: media.getWidht(40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(media.getWidht(10)),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(171, 7, 7, 1),
                            Color.fromRGBO(189, 63, 96, 0.9),
                            Color.fromRGBO(171, 7, 7, 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: media.getWidht(45),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
