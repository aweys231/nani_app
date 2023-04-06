// ignore_for_file: non_constant_identifier_names, unnecessary_import, prefer_const_constructors, implementation_imports, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MyShifts extends StatefulWidget {
  static const routeName = '/my-shifts';
  const MyShifts(this.role_id, this.candidate_id, {super.key});
  final String? role_id;
  final String? candidate_id;
  @override
  State<MyShifts> createState() => _MyShiftsState();
}

class _MyShiftsState extends State<MyShifts> {
  int currentIndex = 0;
  final formatter = DateFormat('E');
  List<DateTime>? days;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0f0f6),
        appBar: AppBar(
          title: Text('MY Shifts'),
        ),
        drawer: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 12, right: 12, top: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 238, 238),
                  // borderRadius: BorderRadius.all(Radius.circular(35)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.calendarDay,
                                          color: currentIndex == 0
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColorLight,
                                          size: currentIndex == 0 ? 30 : 26,
                                        ),
                                        currentIndex == 0
                                            ? Container(
                                                margin: EdgeInsets.only(top: 1),
                                                height: 3,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                              )
                                            : SizedBox(),
                                      ]),
                                  Container(
                                     padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'UPCOMIN',
                                        style: TextStyle(
                                            color: currentIndex == 0
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColorLight,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Lato'
                                            ),
                                        // children: <TextSpan>[
                                        //     TextSpan(text: ' Sign up',
                                        //         style: TextStyle(color: Colors.blueAccent, fontSize: 20)
                                        //     )
                                        // ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child:    Container(
                           decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 238, 238),
                  // borderRadius: BorderRadius.all(Radius.circular(35)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.calendarDay,
                                          color: currentIndex == 1
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColorLight,
                                          size: currentIndex == 1 ? 30 : 26,
                                        ),
                                        currentIndex == 1
                                            ? Container(
                                                margin: EdgeInsets.only(top: 1),
                                                height: 3,
                                                width: 24,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                              )
                                            : SizedBox(),
                                      ]),
                                  Container(
                                   padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'COMPLETED',
                                        style: TextStyle(
                                          
                                            color: currentIndex == 1
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColorLight,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                             fontFamily: 'Lato'),
                                        // children: <TextSpan>[
                                        //     TextSpan(text: ' Sign up',
                                        //         style: TextStyle(color: Colors.blueAccent, fontSize: 20)
                                        //     )
                                        // ]
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  
                    )),
                 
                  ],
                ),
              ),
            ),
           Container(child: schedule(2),)
          ],
        ));
  }


 Card schedule(int index) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: Container(
          height: 80,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            // child: Expanded(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.calendar_month_outlined),
              Text("MON",
                // "${formatter.format(days![index])}",
                style: TextStyle(color: Colors.green, fontSize: 10),
              ),
              Text("3"
                // "${days![index].day}"
              ),
            ]),
            // )
          ),
        ),
        title:
        Center(
  child: Container(
    color: Colors.white,
    width: double.infinity,
    height: 80,
    padding: EdgeInsets.all(1),
    margin: EdgeInsets.all(1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Umberla for sale",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 4),
                Text("200 bought this")
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                child: Text("Cancel"),
                onPressed: () {},
              ),
            ],
          ),
        )
      ],
    ),
  ),
),

        // subtitle: AvaliabiltityDropDown(),
        // trailing:  Text("${formatter.format(days[index])}",
        //   style: TextStyle(color: Colors.green, fontSize: 15),),
      ),
    );
  }

  }