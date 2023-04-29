// ignore_for_file: prefer_const_constructors, implementation_imports, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LicenseType extends StatefulWidget {
  const LicenseType({super.key, this.onChanged});
  final ValueChanged<String>? onChanged;
  
  @override
  State<LicenseType> createState() => _LicenseTypeState();
}

class _LicenseTypeState extends State<LicenseType> {
  String dropdownValue = 'NO';
  @override
  Widget build(BuildContext context) {
     return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 5),
      height: 60,
      child: DropdownButtonFormField(
        // focusNode: regionFocusNode,
        decoration: InputDecoration(
    enabledBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Color.fromARGB(255, 162, 159, 159), width: 1),
     ),
     focusedBorder: OutlineInputBorder( //<-- SEE HERE
      borderSide: BorderSide(color: Color.fromARGB(255, 162, 159, 159), width: 1),
    ),
    filled: true,
     ),
        // decoration: FormStyles.textFieldDecoration(labelText: 'Region'),
        hint: const Text( 'choose License Type', ),
        onChanged: (v) => widget.onChanged!(v!),
        // onChanged: (String? value) {
          
        //   setState(() {
        //     dropdownValue = value!;
        //   });
        // },
        // validator: state.farmer.validateRequiredField,
        // onSaved: state.farmer.saveFarmerCategory,
         items: <String>['CLASS A Commercial', 'CLASS B Commercial', 'CLASS C Commercial ', 'CLASS D Operator', 'CLASS DJ Junior', 'CLASS E For-hire: Taxi', 'CLASS MJ Junior', 'CLASS M Motorcycle' ,'Other'].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: const TextStyle(fontSize: 14),
      ),
      );
  }).toList(),
      ),
    );
  }
}