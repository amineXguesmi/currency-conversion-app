import 'package:currency_conversion/core/providers/archive_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArchiveCard extends StatelessWidget {
  String date;
  String time;
  String conversionFrom;
  String conversionTo;
  ArchiveCard(
      {required this.date,
      required this.time,
      required this.conversionFrom,
      required this.conversionTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: SizedBox(
                      width: 450,
                      height: 240,
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
                              const Center(
                                child: Text(
                                  "Conversion Details",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Date : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(child: Text(this.date)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Time :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(child: Text(this.time)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Conversion from :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(child: Text(this.conversionFrom)),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "conversion to : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Center(child: Text(this.conversionTo)),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ));
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(256, 256, 256, 0.5),
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
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
                      Text(this.date),
                      const SizedBox(
                        height: 6,
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
                    Text(this.conversionTo),
                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Provider.of<ArchiveProvier>(context, listen: false)
                        .deleteConversion(this.time);
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
