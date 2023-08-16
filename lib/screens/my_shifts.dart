// ignore_for_file: non_constant_identifier_names, unnecessary_import, prefer_const_constructors, implementation_imports, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print, dead_code, unused_element, unused_field, prefer_final_fields, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/constants.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

import '../providers/auth.dart';

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
  // List<DateTime>? days;
  late Future _upcominge;
  late Future _completer;
  Future _obtainUpcomingFuture(String candidate_id) {
    return Provider.of<job.Jobs_Section>(context, listen: false)
        .fetchAndSetVacuncyUpcoming(widget.candidate_id.toString());
  }

  Future _obtainCompeletedFuture(String candidate_id) {
    return Provider.of<job.Jobs_Section>(context, listen: false)
        .fetchAndSetVacuncyCompleted(widget.candidate_id.toString());
  }

  var _isInit = true;
  var _isLoading = false;
  var _display = true;
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<Auth>(context, listen: false);
    if (auth.isAuth) {
      auth.autoLogout(DateTime.now().add(Duration(minutes: 5)));
    }
  }
  @override
  didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      setState(() {
        _completer = _obtainCompeletedFuture(widget.candidate_id.toString());
         _upcominge = _obtainUpcomingFuture(widget.candidate_id.toString());
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
          backgroundColor: bggcolor,
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderButtons(context),
           
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
           
                  :
           
            Container(
              child: MyContainer(),
            )
          ],
        ));
  }

  Container HeaderButtons(BuildContext context) {
    return Container(
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
                        _display = true;
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
                                            ? bggcolor : txtcolor,
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
                                              ? bggcolor : txtcolor,
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
                        _display = false;
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
                                            ? bggcolor : txtcolor,
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
                                              ? bggcolor : txtcolor,
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
          );
  }

  Expanded MyContainer() {
    
    return Expanded(
      child: _display
          ?FutureBuilder(
              future: _upcominge,
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return Center(child: Text('An error Accour'));
                    print(dataSnapshot.error);
                  } else {
                    return Consumer<job.Jobs_Section>(
                      builder: (ctx, upcomingData, child) => upcomingData.upcoming.isNotEmpty
              ? CustomScrollView(
                  // center: centerKey,
                  slivers: <Widget>[
                    SliverList(
                      // key: centerKey,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          print('CustomScrollView');
                          return UpcomingSchedule(upcomingData.upcoming[index]);
                        },
                        childCount: upcomingData.upcoming.length,
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                      ),
                    ),
                  ],
                )
              : CustomScrollView(
                  // center: centerKey,
                  slivers: <Widget>[
                    SliverList(
                      // key: centerKey,
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          print('CustomScrollView');
                          return Center(
                            child: const Text(
                              'No results found',
                              style: TextStyle(fontSize: 24),
                            ),
                          );
                        },
                        childCount: 1,
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: true,
                      ),
                    ),
                  ],
                )
                 );
                  }
                }
              })
          : FutureBuilder(
              future: _completer,
              builder: (ctx, dataSnapshot) {
                if (dataSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapshot.error != null) {
                    return Center(child: Text('An error Accour'));
                    print(dataSnapshot.error);
                  } else {
                    return Consumer<job.Jobs_Section>(
                      builder: (ctx, compeletedData, child) =>
                          compeletedData.compeleted.isNotEmpty
                              ? CustomScrollView(
                                  // center: centerKey,
                                  slivers: <Widget>[
                                    SliverList(
                                      // key: centerKey,
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          print('CustomScrollView');
                                          return CompeletedSchedule(
                                              compeletedData.compeleted[index]);
                                        },
                                        childCount: compeletedData.compeleted.length,
                                        addAutomaticKeepAlives: true,
                                        addRepaintBoundaries: true,
                                      ),
                                    ),
                                  ],
                                )
                              : CustomScrollView(
                                  // center: centerKey,
                                  slivers: <Widget>[
                                    SliverList(
                                      // key: centerKey,
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          print('CustomScrollView');
                                          return 
                                          Center(
                                            child: const Text(
                                              'No results found',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          );
                                        },
                                        childCount: 1,
                                        addAutomaticKeepAlives: true,
                                        addRepaintBoundaries: true,
                                      ),
                                    ),
                                  ],
                                ),
                    );
                  }
                }
              }),
    );
  }

  Card UpcomingSchedule(job.UpcomingModel jobs) {
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bggcolor,
                        padding: EdgeInsets.symmetric(vertical: 6,  horizontal: 6),

                      ),
                      child: Text("Cancel"),
                      onPressed: () async {
                        // widget.candidate_id.toString();
                        var message = await Provider.of<job.Jobs_Section>(
                                context,
                                listen: false)
                            .shift_cancelation(jobs.availabilityid);
                        print(message.toString());
                        await showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: Text('success'),
                                  content: Text(message.toString()),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Okey'),
                                      onPressed: () {
                                        // Navigator.of(ctx).pop();
                                        Navigator.of(context).pushReplacementNamed(MyShifts.routeName);
                                      },
                                    )
                                  ],
                                ));
                      },
                    ),
                  ],
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

  Card CompeletedSchedule(job.CompletedgModel jobs) {
    return
     Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 0,
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
                // Container(
                //   decoration: BoxDecoration(
                //   color: Theme.of(context).primaryColor,
                //   borderRadius: BorderRadius.all(Radius.circular(40)),
                //   boxShadow: [
                //     BoxShadow(
                //         color: Colors.black26,
                //         blurRadius: 10,
                //         offset: Offset(2, 2))
                //   ]),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       ElevatedButton(
                //         child: Text("Cancel"),
                //         onPressed: () {},
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),

       
      ),
    );
  }
}
