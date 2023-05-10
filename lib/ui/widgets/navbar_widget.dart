import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/providers/currency_provider.dart';
import '../../core/providers/user_provider.dart';
import '../screens/archive_screen.dart';
import '../screens/home_screen.dart';
import '../utilities/media_query.dart';
import 'custom_dropdown.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media =
        Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);
    return Stack(
      children: [
        Positioned(
          top: media.getHeight(25),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            child: Image(
              width: media.getWidht(120),
              image: const AssetImage('assets/logo.png'),
            ),
          ),
        ),
        Positioned(
          top: media.getHeight(43),
          right: media.getWidht(15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
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
                              Provider.of<UserProvider>(context, listen: false)
                                  .setUsername(value);
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                                hintText: context.read<UserProvider>().userName,
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
                                    context.read<CurrencyProvider>().currencies,
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
                                    context.read<CurrencyProvider>().currencies,
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
              size: media.getWidht(70),
            ),
          ),
        ),
        Positioned(
          top: media.getHeight(50),
          right: media.getWidht(85),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ArchiveScreen()));
            },
            child: Icon(
              FontAwesomeIcons.database,
              size: media.getWidht(57),
            ),
          ),
        ),
      ],
    );
  }
}
