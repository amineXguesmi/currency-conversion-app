import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:currency_conversion/core/providers/user_provider.dart';
import 'package:currency_conversion/ui/widgets/archive_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/currency_provider.dart';
import '../utilities/media_query.dart';
import '../widgets/custom_dropdown.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
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
          Positioned(
            top: media.getHeight(10),
            child: Image(
              width: media.getWidht(110),
              image: AssetImage('assets/logo.png'),
            ),
          ),
          Positioned(
            top: media.getHeight(26),
            right: media.getWidht(15),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    title: Center(
                      child: Text(
                        "Setting",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: media.getWidht(25),
                        ),
                      ),
                    ),
                    content: SizedBox(
                      height: media.getHeight(200),
                      width: media.getWidht(280),
                      child: Column(
                        children: [
                          SizedBox(
                            width: media.getWidht(240),
                            height: media.getHeight(60),
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
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple,
                                          width: media.getWidht(3))),
                                  hintStyle:
                                      const TextStyle(color: Colors.black)),
                            ),
                          ),
                          SizedBox(
                            height: media.getHeight(30),
                          ),
                          SizedBox(
                            width: media.getWidht(240),
                            height: media.getHeight(60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: media.getHeight(100),
                                  width: media.getWidht(90),
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
                                SizedBox(
                                  height: media.getHeight(50),
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: Colors.purple,
                                    size: media.getWidht(50),
                                  ),
                                ),
                                Container(
                                  height: media.getHeight(100),
                                  width: media.getWidht(90),
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
              child: Icon(
                Icons.settings,
                size: media.getWidht(50),
              ),
            ),
          ),
          Positioned(
            top: media.getHeight(30),
            right: media.getWidht(85),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                FontAwesomeIcons.database,
                size: media.getWidht(43),
              ),
            ),
          ),
          Positioned(
            top: media.getHeight(150),
            bottom: media.getHeight(15),
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(media.getWidht(8)),
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
