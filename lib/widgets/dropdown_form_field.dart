// ignore_for_file: unnecessary_import, must_be_immutable, avoid_web_libraries_in_flutter, unused_import, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleDropdownFormField extends StatefulWidget {
  


  const TitleDropdownFormField({super.key});

  @override
  State<TitleDropdownFormField> createState() => _TitleDropdownFormFieldState();
}

class _TitleDropdownFormFieldState extends State<TitleDropdownFormField> {
 String dropdownValue = 'Secodry';

  @override
  Widget build(BuildContext context) {
    return
       Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 15, top: 5),
        child: Expanded(
          // flex: 5,
          child:
//          DropdownButtonFormField(
//   decoration: InputDecoration(
//     enabledBorder: OutlineInputBorder( //<-- SEE HERE
//       borderSide: BorderSide(color: Colors.black, width: 2),
//     ),
//     focusedBorder: OutlineInputBorder( //<-- SEE HERE
//       borderSide: BorderSide(color: Colors.black, width: 2),
//     ),
//     filled: true,
//     fillColor: Colors.greenAccent,
//   ),
//   dropdownColor: Colors.greenAccent,
//   value: dropdownValue,
//   onChanged: (String? newValue) {
//     setState(() {
//       dropdownValue = newValue!;
//     });
//   },
//   items: <String>['Secodry', 'Bachelor', 'Master', 'PHD' ,'Other'].map<DropdownMenuItem<String>>((String value) {
//     return DropdownMenuItem<String>(
//       value: value,
//       child: Text(
//         value,
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }).toList(),
// )
          DropdownButtonFormField(
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
            hint: const Text( 'choose Your Title', ),
            onChanged: (String? value) {
              
              setState(() {
                dropdownValue = value!;
              });
            },
            // validator: state.farmer.validateRequiredField,
            // onSaved: state.farmer.saveFarmerCategory,
             items: <String>['Secodry', 'Bachelor', 'Master', 'PHD' ,'Other'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        );
  }).toList(),
          ),
        ),
    );
  }
}

