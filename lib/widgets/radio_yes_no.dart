// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RadioYesNo extends StatefulWidget {
  const RadioYesNo({super.key});

  @override
  State<RadioYesNo> createState() => _RadioYesNoState();
}

class _RadioYesNoState extends State<RadioYesNo> {
   TextEditingController dateInputController = TextEditingController();
  String selectedValue = 'Yes';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      // margin: const EdgeInsets.only(bottom: 10,top: 5),
      child: ListView(
        shrinkWrap: true,
        // scrollDirection: Axis.horizontal,

        children: [
          Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: RadioListTile<String>(
                        title: Text('Yes'),
                        value: 'Yes',
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        })),
                Expanded(
                    child: RadioListTile<String>(
                        title: Text('No'),
                        value: 'No',
                        groupValue: selectedValue,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        })),
              ])
          // Center(child: Text(selectedValue == 'Male' ? 'Your gender is Male ' : 'Your gender is Female'))
        ],
      ),
    );
  }
}