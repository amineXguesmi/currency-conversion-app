import 'package:currency_conversion/ui/screens/initial_screen.dart';
import 'package:flutter/material.dart';

import '../../core/services/api_client.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  ApiClient client = ApiClient();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencies();
  }

  void getCurrencies() async {
    List<String> currencies = await client.getCurrencies();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InitialScreen(
                  currencies: currencies,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
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
      ),
      child: const Center(
        child: Image(
          image: AssetImage('assets/splach_image.png'),
        ),
      ),
    ));
  }
}
