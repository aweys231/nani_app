// ignore_for_file: unnecessary_import, implementation_imports, unused_import, unnecessary_late, unnecessary_string_interpolations, prefer_const_constructors, unused_element, avoid_unnecessary_containers, depend_on_referenced_packages, unused_local_variable, avoid_print, unnecessary_null_comparison, sized_box_for_whitespace, must_call_super, non_constant_identifier_names, unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nanirecruitment/providers/availability_process.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:nanirecruitment/widgets/availability_dropdown.dart';
import 'package:nanirecruitment/widgets/availability_items.dart';
import 'package:nanirecruitment/widgets/license_type.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
// if (_isInit) {
//      Provider.of<Availability_Section>(context).fetchAndSetshifts().then((_) {

//       });
//     super.didChangeDependencies();
//   }
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
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No Timetable Selected yet !',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
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
                          child:
                              // calander(days!),
                              schedulelist(days!),
                        ),
                        Container(height: 65, child: submit(context)),
                      ],
                    );
                  })
        // calander(days!),

        );
  }

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
                    "${days![index].day.toString()}/${days![index].month.toString()}/${days![index].year.toString()}").toString()
           
            ),

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
}
