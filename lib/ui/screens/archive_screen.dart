import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:currency_conversion/ui/widgets/archive_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/media_query.dart';
import '../widgets/navbar_widget.dart';

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
          NavBar(),
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
