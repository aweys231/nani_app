// ignore_for_file: prefer_const_constructors, implementation_imports, unnecessary_import, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nanirecruitment/providers/candidate_registration.dart';
import 'package:provider/provider.dart';

class Natitinality extends StatefulWidget {
  const Natitinality({super.key, this.onChanged});
  final ValueChanged<String>? onChanged;

  @override
  State<Natitinality> createState() => _NatitinalityState();
}

class _NatitinalityState extends State<Natitinality> {
 
  String dropdownValue = 'NO';
  @override
  Widget build(BuildContext context) {
     Provider.of<Candidate>(context).fetchAndSetnatinality();
     final nationality = Provider.of<Candidate>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 5),
      height: 60,
      child: Expanded(
        // flex: 5,
        child: DropdownButtonFormField(
          // focusNode: regionFocusNode,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              //<-- SEE HERE
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 162, 159, 159), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              //<-- SEE HERE
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 162, 159, 159), width: 1),
            ),
            filled: true,
          ),
          // decoration: FormStyles.textFieldDecoration(labelText: 'Region'),
          hint: const Text(
            'choose Nationality',
          ),
          onChanged: (v) => widget.onChanged!(v!),
          // onChanged: (String? value) {

          //   setState(() {
          //     dropdownValue = value!;
          //   });
          // },
          // validator: state.farmer.validateRequiredField,
          // onSaved: state.farmer.saveFarmerCategory,
          items: nationality.nationality.map((data) {
          return DropdownMenuItem<String>(
            value: data.id,
            child: Text(
              data.name,
              style: const TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
        ),
      ),
    );
  }
}
