import 'package:flutter/material.dart';

//TODO:fix drop down
//TODO:fix the swap icon
class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedCurrencyFrom = 'USD';
    String selectedCurrencyTo = 'EUR';
    List<String> _currencies = ['USD', 'EUR', 'JPY', 'GBP', 'CAD', 'AUD'];
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
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
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "UserName",
                    prefixIcon: Icon(
                      Icons.person,
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
          top: 420,
          left: 20,
          right: 210,
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
          top: 445,
          left: 163,
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
          top: 420,
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
          top: 520,
          left: 60,
          right: 60,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
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
    );
  }
}
