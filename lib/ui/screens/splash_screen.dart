import 'package:currency_conversion/core/providers/archive_provider.dart';
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
  String error = "";
  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  void getCurrencies() async {
    try {
      await Provider.of<CurrencyProvider>(context, listen: false)
          .fetchCurrencies();
      await Provider.of<ArchiveProvier>(context, listen: false).loadList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if ((prefs.getString("username") != null) &&
          (prefs.getString("defaultFrom") != null) &&
          (prefs.getString("defaultTo") != null)) {
        await Provider.of<UserProvider>(context, listen: false)
            .getStorageData();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InitialScreen()));
      }
    } catch (e) {
      if (e.toString() ==
          "Exception: Error occured while fetching api , please try again later") {
        setState(() {
          error = "Error occured while fetching api , please try again later";
        });
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Center(
              child: Text(
                "Opppsss",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
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
                  SizedBox(
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
            )),
      );
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
          fit: BoxFit.contain,
          image: AssetImage('assets/splach_image.png'),
        ),
      ),
    ));
  }
}
