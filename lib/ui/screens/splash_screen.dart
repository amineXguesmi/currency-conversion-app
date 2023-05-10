import 'package:currency_conversion/core/providers/user_provider.dart';
import 'package:currency_conversion/ui/screens/initial_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/providers/currency_provider.dart';
import '../../core/services/api_client.dart';
import 'home_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  ApiClient client = ApiClient();
  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  void getCurrencies() async {
    await Provider.of<CurrencyProvider>(context, listen: false)
        .fetchCurrencies();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if ((prefs.getString("username") != null) &&
        (prefs.getString("defaultFrom") != null) &&
        (prefs.getString("defaultTo") != null)) {
      await Provider.of<UserProvider>(context, listen: false).getStorageData();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const InitialScreen()));
    }
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
