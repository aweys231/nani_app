// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, avoid_unnecessary_containers, unused_local_variable, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CanidateAttandance extends StatefulWidget {
  const CanidateAttandance({super.key});
  static const routeName = '/candidate-attandance';

  @override
  State<CanidateAttandance> createState() => _CanidateAttandanceState();
}

class _CanidateAttandanceState extends State<CanidateAttandance> {
  double screenHeight = 0;
  double screenWidth = 0;
  String checkInt = '--/--';
  String checkOut = '--/--';
  void getRecode() async {
    try {
      setState(() {
        checkInt = 'checkInt';
        checkOut = 'checkOut';
      });
    } catch (e) {
      setState(() {
        checkInt = '--/--';
        checkOut = '--/--';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "wellcom",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth / 20,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              // margin: EdgeInsets.only(top: 32),
              child: Text(
                "Canidate",
                style: TextStyle(
                  color: Color.fromARGB(255, 227, 73, 73),
                  fontSize: screenWidth / 18,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "To days Status",
                style: TextStyle(
                  fontSize: screenWidth / 18,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Check In",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          "12:30",
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          "17:30",
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(color: Colors.purple),
                      children: [
                        TextSpan(
                          text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        )
                      ]),
                )),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          fontFamily: 'Lato',
                          color: Colors.black54),
                    ),
                  );
                }),
            checkOut == '--/--'
                ? Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Builder(builder: (context) {
                      final GlobalKey<SlideActionState> key = GlobalKey();
                      return SlideAction(
                        text: checkInt == '--/--'
                            ? "Slide check In"
                            : "Slide check Out",
                        textStyle: TextStyle(
                            fontSize: screenWidth / 20,
                            fontFamily: 'Lato',
                            color: Colors.black54),
                        outerColor: Colors.white,
                        innerColor: Colors.purple,
                        key: key,
                        onSubmit: (() {
                          key.currentState!.reset();
                          getRecode();
                        }),
                      );
                    }),
                  )
                : Container(
                    child: Text('You have already check out'),
                  ),
          ],
        ),
      ),
    );
  }
}
