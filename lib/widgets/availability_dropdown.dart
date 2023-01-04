// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/providers/availability_process.dart';
import 'package:provider/provider.dart';

class AvaliabiltityDropDown extends StatefulWidget {
  final String candidateid;
  final String year;
  final String month;
  final String day;
  final String dayname;
  const AvaliabiltityDropDown(
      {super.key,
      required this.candidateid,
      required this.year,
      required this.month,
      required this.day,
      required this.dayname});

  // const AvaliabiltityDropDown({super.key, this.onChanged});
  // final ValueChanged<String>? onChanged;

  @override
  State<AvaliabiltityDropDown> createState() => _AvaliabiltityDropDownState();
}

class _AvaliabiltityDropDownState extends State<AvaliabiltityDropDown> with AutomaticKeepAliveClientMixin {
  String dropdownValue = 'NO';
  final List<Shifts_Model> shiftsData = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final shifts = Provider.of<Availability_Section>(context, listen: false);

    var shiftItem;
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      height: 60,
      child: DropdownButtonFormField(
        // focusNode: regionFocusNode,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            //<-- SEE HERE
            borderSide: BorderSide(
                color: Color.fromARGB(255, 255, 255, 255), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            //<-- SEE HERE
            borderSide: BorderSide(
                color: Color.fromARGB(255, 255, 255, 255), width: 1),
          ),
          // filled: true,
        ),
        // decoration: FormStyles.textFieldDecoration(labelText: 'Region'),
        hint: const Text(
          'choose Shift',
        ),
        onChanged: (value) {
          // print(widget.dayname);
          // print(dropdownValue);
          // print('widget.day');
          // this function will remove if there is  prrvious select if the user change the previous selecting
          Provider.of<Availability_Section>(context, listen: false)
              .removeSingleItem(widget.day.toString());
          // this will add the model the new selection of the user
          Provider.of<Availability_Section>(context, listen: false).addItem(
            widget.candidateid,
            value!,
            widget.year,
            widget.month,
            widget.day,
            widget.dayname,
          );
        },

        items: shifts.availability.map((sh) {
          
          return DropdownMenuItem<String>(
            value: sh.id,
            child: Text(
              sh.name,
              style: const TextStyle(fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
