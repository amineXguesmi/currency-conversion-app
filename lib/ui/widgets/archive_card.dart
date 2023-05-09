import 'package:flutter/material.dart';

class ArchiveCard extends StatelessWidget {
  const ArchiveCard({Key? key}) : super(key: key);

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
                      height: 200,
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
                            children: const [
                              Center(
                                child: Text(
                                  "Conversion Details",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Date : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(child: Text("**//****/**")),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Time :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(child: Text("11100:1000")),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Conversion from :",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(child: Text("123132USD")),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "conversion to : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(child: Text("15646Dn")),
                            ],
                          ))
                        ],
                      ),
                    ),
                  ));
        },
        child: Container(
          height: 40,
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
            children: const [
              Expanded(
                flex: 1,
                child: Center(child: Text("id")),
              ),
              Expanded(
                  flex: 1,
                  child: VerticalDivider(
                    thickness: 3,
                    color: Colors.black,
                  )),
              Expanded(
                flex: 6,
                child: Center(child: Text("Date")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
