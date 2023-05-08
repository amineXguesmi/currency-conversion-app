import 'package:currency_conversion/ui/widgets/archive_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

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
              onTap: () {},
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
                  children: const [
                    ArchiveCard(),
                    ArchiveCard(),
                    ArchiveCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
