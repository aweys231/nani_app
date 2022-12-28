// ignore_for_file: unnecessary_import, implementation_imports, unused_import, unnecessary_late, unnecessary_string_interpolations, prefer_const_constructors, unused_element, avoid_unnecessary_containers, depend_on_referenced_packages, unused_local_variable, avoid_print, unnecessary_null_comparison, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:nanirecruitment/widgets/availability_dropdown.dart';
import 'package:nanirecruitment/widgets/license_type.dart';
import 'package:path/path.dart';

class Availability extends StatefulWidget {
  static const routeName = '/availability';
  const Availability({super.key});

  @override
  State<Availability> createState() => _AvailabilityState();
}

var _isInit = true;
DateTime? _selected;
 List<DateTime>? days;

 // function will count the month we selected number of day consit
  int getDaysInMonth() {
  if (_selected!.month == DateTime.february) {
    final bool isLeapYear = (_selected!.year % 4 == 0) && (_selected!.year % 100 != 0) || (_selected!.year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysInMonth[_selected!.month- 1];
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

class _AvailabilityState extends State<Availability> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff0f0f6),
      appBar: AppBar(title: Text('Availability'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.calendar_month_outlined),
            onPressed: () =>
              _onPressed(context: context)  
            ),
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
          : calander(days!),
    );
  }

  ListView calander(List<DateTime> day) {
    return ListView.builder(
        itemCount: day.length,
        itemBuilder: (BuildContext context, int index) {
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
                    child: Expanded(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.calendar_month_outlined),
                        Text(
                          "${formatter.format(days![index])}",
                          style: TextStyle(color: Colors.green, fontSize: 10),
                        ),
                        Text("${days![index].day}"),
                      ]),
                    )),
              ),
              title: AvaliabiltityDropDown(),
              // subtitle: AvaliabiltityDropDown(),
              // trailing:  Text("${formatter.format(days[index])}",
              //   style: TextStyle(color: Colors.green, fontSize: 15),),
            ),
          );
        });
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