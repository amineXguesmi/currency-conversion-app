import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:currency_conversion/core/providers/currency_provider.dart';
import 'package:currency_conversion/core/providers/rate_provider.dart';
import 'package:currency_conversion/core/providers/user_provider.dart';
import 'package:currency_conversion/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrencyProvider>(
          create: (_) => CurrencyProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<ArchiveProvider>(
          create: (_) => ArchiveProvider(),
        ),
        ChangeNotifierProvider<RateProvider>(
          create: (_) => RateProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(
          child: SplachScreen(),
        ),
      ),
    );
  }
}
