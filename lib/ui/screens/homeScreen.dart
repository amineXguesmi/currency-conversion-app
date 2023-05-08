import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedCurrencyFrom = 'USD';
    String selectedCurrencyTo = 'EUR';
    List<String> _currencies = ['USD', 'EUR', 'JPY', 'GBP', 'CAD', 'AUD'];
    return Stack(
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
            onTap: () {},
            child: Icon(
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
            child: Icon(
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
              child: DropdownButtonFormField<String>(
                menuMaxHeight: 150,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "UserName",
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 3)),
                    hintStyle: TextStyle(color: Colors.black)),
                value: selectedCurrencyFrom,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrencyFrom = newValue!;
                  });
                },
                items:
                    _currencies.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
                setState(() {
                  String tempCurrency = selectedCurrencyFrom;
                  selectedCurrencyFrom = selectedCurrencyTo;
                  selectedCurrencyTo = tempCurrency;
                });
              },
              child: Container(
                child: Icon(
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
              child: DropdownButtonFormField<String>(
                menuMaxHeight: 150,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 3)),
                    hintStyle: TextStyle(color: Colors.black)),
                value: selectedCurrencyTo,
                icon: Icon(Icons.arrow_drop_down),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrencyTo = newValue!;
                  });
                },
                items:
                    _currencies.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Input Amount",
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Colors.purple,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 3)),
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ),
        Positioned(
          top: 400,
          left: 20,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Output Amount",
                    enabled: false,
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Colors.purple,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 3)),
                    hintStyle: TextStyle(color: Colors.black)),
              ),
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
                  child: Text(
                    "save",
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
                  child: Text(
                    "discard",
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
    );
  }
}
