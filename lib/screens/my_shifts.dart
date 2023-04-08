// ignore_for_file: non_constant_identifier_names, unnecessary_import, prefer_const_constructors, implementation_imports, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print, dead_code, unused_element, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

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
  late Future _jobsFuture;
  Future _obtainOrdersFuture(String candidate_id) {
    return Provider.of<job.Jobs_Section>(context, listen: false)
        .fetchAndSetVacuncyUpcoming(widget.candidate_id.toString());
  }

  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      setState(() {
        _jobsFuture = _obtainOrdersFuture(widget.candidate_id.toString());

        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff0f0f6),
        appBar: AppBar(
          title: Text('MY Shifts'),
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65,
              margin: EdgeInsets.only(left: 5, right: 5, top: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
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
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
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
            Container(
              child: Expanded(
                  child:
                      // _foundJob.isNotEmpty
                      //     ?
                      FutureBuilder(
                          future: _jobsFuture,
                          builder: (ctx, dataSnapshot) {
                            if (dataSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              if (dataSnapshot.error != null) {
                                return Center(child: Text('An error Accour'));
                                print(dataSnapshot.error);
                              } else {
                                return Consumer<job.Jobs_Section>(
                                    builder: (ctx, jobData, child) => Expanded(
                                          child: jobData.upcoming.isNotEmpty
                                              ?
                                              //  ListView.builder(
                                              //   // scrollDirection: Axis.horizontal,
                                              //   itemCount: jobData.upcoming.length,
                                              //   itemBuilder: (ctx, i) =>
                                              //       JobContainer(jobData.upcoming[i]),
                                              // )
                                              CustomScrollView(
                                                  // center: centerKey,
                                                  slivers: <Widget>[
                                                    SliverList(
                                                      // key: centerKey,
                                                      delegate:
                                                          SliverChildBuilderDelegate(
                                                        (BuildContext context,
                                                            int index) {
                                                          print(
                                                              'CustomScrollView');
                                                          return schedule(
                                                              jobData.upcoming[
                                                                  index]);
                                                        },
                                                        childCount: jobData
                                                            .upcoming.length,
                                                        addAutomaticKeepAlives:
                                                            true,
                                                        addRepaintBoundaries:
                                                            true,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Center(
                                                  child: const Text(
                                                    'No results found',
                                                    style:
                                                        TextStyle(fontSize: 24),
                                                  ),
                                                ),
                                          // GridView.count(
                                          //         primary: true,
                                          //         crossAxisCount: 2,
                                          //         childAspectRatio: 0.80,
                                          //         children: List.generate(orderData.categories.length, (i) => CategoryCard(orderData.categories[i])),
                                          // ),
                                        ));
                              }
                            }
                          })),
            )
          ],
        ));
  }

  Card schedule(job.UpcomingModel jobs) {
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
              Text(
                jobs.dayname,
                // "${formatter.format(days![index])}",
                style: TextStyle(color: Colors.green, fontSize: 10),
              ),
              Text(jobs.daynumber
                  // "${days![index].day}"
                  ),
            ]),
            // )
          ),
        ),
        title: Center(
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
                          "Shift ${jobs.shiftname}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          jobs.companies_name,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          jobs.address,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ]),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
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
