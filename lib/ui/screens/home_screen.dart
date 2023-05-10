import 'package:currency_conversion/core/models/conversion.dart';
import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/user_provider.dart';
import '../../core/services/api_client.dart';
import '../utilities/media_query.dart';
import '../widgets/navbar_widget.dart';

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
      TextEditingController(text: null);
  final TextEditingController outputController =
      TextEditingController(text: null);

  @override
  void dispose() {
    inputController.dispose();
    outputController.dispose();
    super.dispose();
  }

  void convertInputToOutput(from, to) async {
    double rate = await client.getRate(from, to);
    double inputValue = double.tryParse(inputController.text) ?? 0;
    input = inputController.text;
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
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media =
        Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          NavBar(),
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
                Provider.of<UserProvider>(context, listen: false)
                    .swipeDefault();
                convertInputToOutput(context.read<UserProvider>().defaultFrom,
                    context.read<UserProvider>().defaultTo);
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
                  border: OutlineInputBorder(),
                  hintText: "Input Amount",
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: Colors.purple,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: media.getWidht(3))),
                  hintStyle: const TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  convertInputToOutput(context.read<UserProvider>().defaultFrom,
                      context.read<UserProvider>().defaultTo);
                },
              ),
            ),
          ),
          Positioned(
            top: media.getHeight(420),
            left: media.getWidht(20),
            right: media.getWidht(20),
            child: Padding(
              padding: EdgeInsets.all(media.getWidht(20)),
              child: TextField(
                controller: outputController,
                enabled: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Output Amount",
                  prefixIcon: Icon(
                    Icons.numbers,
                    color: Colors.purple,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: media.getWidht(3))),
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
            top: media.getHeight(650),
            left: media.getWidht(20),
            right: media.getWidht(20),
            child: Padding(
              padding: EdgeInsets.only(
                  left: media.getWidht(10), right: media.getWidht(10)),
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
                      '$input:${context.read<UserProvider>().defaultFrom}';
                  String conversionTo =
                      '$output:${context.read<UserProvider>().defaultTo}';
                  Conversion conversion = Conversion(
                      date: date,
                      time: time,
                      conversionFrom: conversionFrom,
                      conversionTo: conversionTo);
                  print(conversion.conversionFrom);
                  Provider.of<ArchiveProvier>(context, listen: false)
                      .AddConversion(conversion);
                },
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
          Positioned(
            top: media.getHeight(730),
            left: media.getWidht(20),
            right: media.getWidht(20),
            child: Padding(
              padding: EdgeInsets.only(
                  left: media.getWidht(10), right: media.getWidht(10)),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false,
                  );
                },
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
        ],
      ),
    );
  }
}
