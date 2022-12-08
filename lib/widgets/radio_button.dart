// ignore_for_file: implementation_imports, avoid_unnecessary_containers, unnecessary_import, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RadioButton extends StatefulWidget {
  const RadioButton(
      {super.key,
      required this.radio_one,
      required this.radio_two,
      required this.radio_one_value,
      required this.radio_two_value, this.onChanged,this.selectedValue});
  final String radio_one;
  final String radio_two;
  final String radio_one_value;
  final String radio_two_value;
  final ValueChanged<String>? onChanged;
  final String? selectedValue ;

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  TextEditingController dateInputController = TextEditingController();
  // String selectedValue = 'Male';
  @override
  Widget build(BuildContext context) {
    // selectedValue = widget.radio_one;
    return SizedBox(
      height: 65,
      // margin: const EdgeInsets.only(bottom: 10,top: 5),
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          // scrollDirection: Axis.horizontal,

          children: [
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: RadioListTile<String>(
                          title: Text(widget.radio_one),
                          value: widget.radio_one_value,
                          groupValue: widget.selectedValue,
                          onChanged: (v) =>widget.onChanged!(v!),)),
                  Expanded(
                      child: RadioListTile<String>(
                          title: Text(widget.radio_two),
                          value: widget.radio_two_value,
                          groupValue: widget.selectedValue,
                          onChanged:  (v) =>widget.onChanged!(v!),)),
                ])
            // Center(child: Text(selectedValue == 'Male' ? 'Your gender is Male ' : 'Your gender is Female'))
          ],
        ),
      ),
    );
  }
}
