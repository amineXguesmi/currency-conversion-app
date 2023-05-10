import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utilities/media_query.dart';

class ArchiveCard extends StatelessWidget {
  String date;
  String time;
  String conversionFrom;
  String conversionTo;
  ArchiveCard(
      {super.key,
      required this.date,
      required this.time,
      required this.conversionFrom,
      required this.conversionTo});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    Mediaquery media =
        Mediaquery(mediaHeight: deviceHeight, mediaWidth: deviceWidth);
    return Padding(
      padding: EdgeInsets.all(media.getWidht(12.0)),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: SizedBox(
                      width: media.getWidht(450),
                      height: media.getHeight(240),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/conversion.png",
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Conversion Details",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: media.getWidht(18),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: media.getHeight(15),
                              ),
                              Text(
                                "Date : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: media.getWidht(15)),
                              ),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Center(child: Text(date)),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Text(
                                "Time :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: media.getWidht(15)),
                              ),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Center(child: Text(time)),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Text(
                                "Conversion from :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: media.getWidht(15)),
                              ),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Center(child: Text(conversionFrom)),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Text(
                                "conversion to : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: media.getWidht(15)),
                              ),
                              SizedBox(
                                height: media.getHeight(5),
                              ),
                              Center(child: Text(conversionTo)),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ));
        },
        child: Container(
          height: media.getHeight(60),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(media.getWidht(10)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(256, 256, 256, 0.5),
                  blurRadius: media.getWidht(20),
                  offset: Offset(0, 10),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: media.getWidht(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Center(
                        child: Text(
                          "Date :",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(date),
                      SizedBox(
                        height: media.getHeight(6),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                  flex: 1,
                  child: VerticalDivider(
                    thickness: 3,
                    color: Colors.black,
                  )),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Result of Conversion :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(conversionTo),
                    SizedBox(
                      height: media.getHeight(6),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<ArchiveProvier>(context, listen: false)
                        .deleteConversion(time);
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
