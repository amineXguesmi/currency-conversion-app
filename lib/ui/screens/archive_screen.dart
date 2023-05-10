import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:currency_conversion/core/providers/user_provider.dart';
import 'package:currency_conversion/ui/widgets/archive_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/currency_provider.dart';
import '../widgets/custom_dropdown.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
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
              onTap: () {},
              child: const Icon(
                FontAwesomeIcons.database,
                size: 43,
              ),
            ),
          ),
          Positioned(
            top: 150,
            bottom: 15,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    children: context
                        .watch<ArchiveProvier>()
                        .conversionList
                        .map((e) => ArchiveCard(
                              date: e.date,
                              time: e.time,
                              conversionFrom: e.conversionFrom,
                              conversionTo: e.conversionTo,
                            ))
                        .toList()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
