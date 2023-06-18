// ignore_for_file: unnecessary_import, implementation_imports, unused_import, unnecessary_late, unnecessary_string_interpolations, prefer_const_constructors, unused_element, avoid_unnecessary_containers, depend_on_referenced_packages, unused_local_variable, avoid_print, unnecessary_null_comparison, sized_box_for_whitespace, must_call_super, non_constant_identifier_names, unused_field, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, deprecated_member_use, dead_code, unnecessary_new

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nanirecruitment/providers/availability_process.dart';
import 'package:nanirecruitment/screens/auth_screen.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:nanirecruitment/widgets/availability_dropdown.dart';
import 'package:nanirecruitment/widgets/availability_items.dart';
import 'package:nanirecruitment/widgets/license_type.dart';
import 'package:path/path.dart';

import 'package:provider/provider.dart';
import 'package:nanirecruitment/providers/jobs.dart' as job;

class Availability extends StatefulWidget {
  static const routeName = '/availability';
  const Availability(this.candidate_id, {super.key});
  final String? candidate_id;

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  var _isInit = true;

  var _isLoading = false;
  var _isInitav = true;

  var _isLoadingav = false;
  DateTime? _selected;
  List<DateTime>? days;

  // function will count the month we selected number of day consit
  int getDaysInMonth() {
    if (_selected!.month == DateTime.february) {
      final bool isLeapYear =
          (_selected!.year % 4 == 0) && (_selected!.year % 100 != 0) ||
              (_selected!.year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[_selected!.month - 1];
  }

  List months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  String getMonth(int currentMonthIndex) {
    return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
  }

// function will care list the month we selected
  void _days() {
    days = List.generate(
      getDaysInMonth(),
      // 7 * 4, // 4weeks
      (index) => _selected!.add(
        Duration(days: index),
      ),
    );
  }

  final formatter = DateFormat('E');
  int currentIndex = 0;
  var _display = true;

  late Future _myavailability;
  late Future _mybooking;
  Future _obtainmyavailabilityFuture(
    String candidate_id,
  ) {
    return Provider.of<Availability_Section>(this.context, listen: false)
        .fetchAndSetMyAvailability(widget.candidate_id.toString());
  }

  Future _obtainMyBookingFuture(
    String candidate_id,
  ) {
    return Provider.of<Availability_Section>(this.context, listen: false)
        .fetchAndSetMyBooking(widget.candidate_id.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BuildContext? context;
    if(widget.candidate_id==null)
    {
      Navigator.pushReplacement(context!, MaterialPageRoute(
            builder: (ctx) => AuthScreen()));
    }
    if (_isInitav) {
      setState(() {
        _isLoadingav = true;
      });

      setState(() {
        _myavailability =
            _obtainmyavailabilityFuture(widget.candidate_id.toString());
        _mybooking = _obtainMyBookingFuture(widget.candidate_id.toString());
        _isLoadingav = false;
      });
    }
    _isInitav = false;
  }

  // var _availability;
  // final shifts =  Provider.of<Shifts_Model>(context, listen: false);
  Future<void> _saveForm(BuildContext context) async {
    // _availability = shifts;
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Availability_Section>(context, listen: false)
          .addAvailability(widget.candidate_id.toString());
    } catch (error) {
      print(error);
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('An error accurred!'),
                content: Text(error.toString()),
                actions: <Widget>[
                  TextButton(
                    child: Text('Okey'),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
                ],
              ));
    }

    setState(() {
      _isLoading = false;
      _isInit = true;
    });
    // Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Availability_Section>(context).fetchAndSetshifts();
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
        backgroundColor: Color(0xfff0f0f6),
        appBar: AppBar(title: Text('schedule'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.calendar_month_outlined),
              onPressed: () => _onPressed(context: context)),
        ]),
        drawer: AppDrawer(),
        body: _isInit
            ? _isLoadingav
                ? Center(child: CircularProgressIndicator())
                : LayoutBuilder(builder: (ctx, constraints) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderButtons(context),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          // height: constraints.maxHeight * 0.6,
                          child: MyContainer(context),
                        )
                      ],
                    );
                  })
            : _isLoading
                ? Center(child: CircularProgressIndicator())
                : LayoutBuilder(builder: (ctx, constraints) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.9,
                          child: schedulelist(days!),
                        ),
                        Container(height: 65, child: submit(context)),
                      ],
                    );
                  }));
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
                color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.calendarDay,
                                  color: currentIndex == 0
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).primaryColorLight,
                                  size: currentIndex == 0 ? 30 : 26,
                                ),
                                currentIndex == 0
                                    ? Container(
                                        margin: EdgeInsets.only(top: 1),
                                        height: 3,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      )
                                    : SizedBox(),
                              ]),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: RichText(
                              text: TextSpan(
                                text: 'My Availability',
                                style: TextStyle(
                                    color: currentIndex == 0
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColorLight,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Lato'),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.calendarDay,
                                  color: currentIndex == 1
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).primaryColorLight,
                                  size: currentIndex == 1 ? 30 : 26,
                                ),
                                currentIndex == 1
                                    ? Container(
                                        margin: EdgeInsets.only(top: 1),
                                        height: 3,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      )
                                    : SizedBox(),
                              ]),
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: RichText(
                              text: TextSpan(
                                text: 'My Booking',
                                style: TextStyle(
                                    color: currentIndex == 1
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColorLight,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Lato'),
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

  Expanded MyContainer(BuildContext context) {
    return Expanded(
      child: _display
          ? FutureBuilder(
              future: _myavailability,
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
                    return Consumer<Availability_Section>(
                        builder: (ctx, availabilityData, child) =>
                            availabilityData.myAvailability.isNotEmpty
                                ? CustomScrollView(
                                    // center: centerKey,
                                    slivers: <Widget>[
                                      SliverList(
                                        // key: centerKey,
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            print('CustomScrollView');
                                            return Container(
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: MyAvailability(
                                                            availabilityData
                                                                    .myAvailability[
                                                                index],
                                                            context),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          childCount: availabilityData
                                              .myAvailability.length,
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
                                  ));
                  }
                }
              })
          : FutureBuilder(
              future: _mybooking,
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
                    return Consumer<Availability_Section>(
                      builder: (ctx, mybookData, child) =>
                          mybookData.booking.isNotEmpty
                              ? CustomScrollView(
                                  // center: centerKey,
                                  slivers: <Widget>[
                                    SliverList(
                                      // key: centerKey,
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          print('CustomScrollView');
                                          return MyBooking(
                                              mybookData.booking[index],context);
                                        },
                                        childCount:
                                            mybookData.booking.length,
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
                                ),
                    );
                  }
                }
              }),
    );
  }

  Card MyAvailability(MyAvailability_Model av, BuildContext context) {
 
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: RichText(
                    text: TextSpan(
                        text:
                        // formattedDate,
                        DateFormat(' MMMM d,yyyy').format(DateTime.parse(av.fulldate)),                
                        style: TextStyle(
                            color: currentIndex == 1
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColorLight,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato')),
                  ),
                ),
                Text(
                  "....",
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),
                      child: Column(
                          // mainAxisSize:
                          //     MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week Day'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: av.shift == 'Week Day' ? 18 : 15,
                            ),
                            av.shift == 'Week Day'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Week Day',
                                  style: TextStyle(
                                      color: av.shift == 'Week Day'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),
                      // child: Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week Night'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: av.shift == 'Week Night' ? 18 : 15,
                            ),
                            av.shift == 'Week Night'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Week Night',
                                  style: TextStyle(
                                      color: av.shift == 'Week Night'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                      // )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),

                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week-End Day'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: av.shift == 'Week-End Day' ? 18 : 15,
                            ),
                            av.shift == 'Week-End Day'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text:'Week-End Day',
                                  style: TextStyle(
                                      color: av.shift == 'Week-End Day'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                      // )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),

                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week-End Night'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: currentIndex == 0 ? 18 : 15,
                            ),
                            av.shift == 'Week-End Night'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Week-End Night',
                                  style: TextStyle(
                                      color: av.shift == 'Week-End Night'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                      // )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Card MyBooking(MyBookin_Model av, BuildContext context) {
 
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: RichText(
                    text: TextSpan(
                        text:
                        // formattedDate,
                        DateFormat(' MMMM d,yyyy').format(DateTime.parse(av.fulldate)),                
                        style: TextStyle(
                            color: currentIndex == 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).primaryColorLight,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato')),
                  ),
                ),
                Text(
                  "....",
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),
                      child: Column(
                          // mainAxisSize:
                          //     MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week Day'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: av.shift == 'Week Day' ? 18 : 15,
                            ),
                            av.shift == 'Week Day'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Week Day',
                                  style: TextStyle(
                                      color: av.shift == 'Week Day'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),
                      // child: Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week Night'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: av.shift == 'Week Night' ? 18 : 15,
                            ),
                            av.shift == 'Week Night'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Week Night',
                                  style: TextStyle(
                                      color: av.shift == 'Week Night'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                      // )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0),

                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week-End Day'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: av.shift == 'Week-End Day' ? 18 : 15,
                            ),
                            av.shift == 'Week-End Day'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text:'Week-End Day',
                                  style: TextStyle(
                                      color: av.shift == 'Week-End Day'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                      // )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  leading: Container(
                    height: 80,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),

                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: av.shift == 'Week-End Night'
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              size: currentIndex == 0 ? 18 : 15,
                            ),
                            av.shift == 'Week-End Night'
                                ? Container(
                                    margin: EdgeInsets.only(top: 1),
                                    height: 3,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(height: 2),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Week-End Night',
                                  style: TextStyle(
                                      color: av.shift == 'Week-End Night'
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColorLight,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                            ),
                          ]),
                      // )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


// start of availablity creating
  CustomScrollView schedulelist(List<DateTime> day) {
    return CustomScrollView(
      // center: centerKey,
      slivers: <Widget>[
        SliverList(
          // key: centerKey,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              print('CustomScrollView');
              return schedule(index);
            },
            childCount: day.length,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
          ),
        ),
      ],
    );
  }

  Container submit(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      // margin: const EdgeInsets.only(bottom: 10, top: 5),
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      // color: Colors.blue,
      child: ButtonTheme(
        minWidth: 200.0,
        height: 100.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).primaryTextTheme.button!.color,
            backgroundColor: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          ),
          onPressed: () {
            _saveForm(context);
          },
          child: const Text('Submit'),
        ),
      ),
    );
  }

  ListView calander(List<DateTime> day) {
    return ListView.builder(
        itemCount: day.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        cacheExtent: 30,
        itemBuilder: (BuildContext context, int index) {
          print('ListView');
          return schedule(index);
        });
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
          color: Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            // child: Expanded(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.calendar_month_outlined),
              Text(
                "${formatter.format(days![index])}",
                style: TextStyle(color: Colors.green, fontSize: 10),
              ),
              Text("${days![index].day}"),
            ]),
            // )
          ),
        ),
        title: AvaliabiltityDropDown(
            candidateid: widget.candidate_id.toString(),
            year: days![index].year.toString(),
            month: getMonth(days![index].month),
            // months[days![index].month-1],
            day: days![index].day.toString(),
            dayname: formatter.format(days![index]).toString(),
            fulldate: DateFormat("dd/MM/yyyy")
                .parse(
                    "${days![index].day.toString()}/${days![index].month.toString()}/${days![index].year.toString()}")
                .toString()),

        // subtitle: AvaliabiltityDropDown(),
        // trailing:  Text("${formatter.format(days[index])}",
        //   style: TextStyle(color: Colors.green, fontSize: 15),),
      ),
    );
  }

  void _onPressed({
    required BuildContext context,
    String? locale,
  }) async {
    setState(() {
      _isInit = true;
    });
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2050),
      locale: localeObj,
    );

    // final selected = await showDatePicker(
    //   context: context,
    //   initialDate: _selected ?? DateTime.now(),
    //   firstDate: DateTime(2019),
    //   lastDate: DateTime(2022),
    //   locale: localeObj,
    // );

    if (selected != null) {
      setState(() {
        _selected = selected;
        print(selected);
        setState(() {
          _days();
          days?.clear();
          _days();
        });
      });
      _isInit = false;
    }
  }
  // end of availablity creating
}
