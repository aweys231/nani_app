// ignore_for_file: avoid_web_libraries_in_flutter, unnecessary_import, unused_import

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  final int? maxlines;
  final int? maxlength;
  final Icon? icon;

  const CustomInput(
      {Key? key,
      this.onChanged,
      this.hint,
      this.controller,
      this.label,
      this.keyboardtype,
      this.maxlines,
      this.maxlength, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: TextField(
        onChanged: (v) => onChanged!(v),
        keyboardType: keyboardtype,
        maxLines: maxlines,
        maxLength: maxlength,
        controller:controller,
        decoration: InputDecoration(
          hintText: hint!,
          labelText: label,
          border: OutlineInputBorder( borderRadius: BorderRadius.circular(10),),
          prefixIcon: icon,
        ),
        
      ),
    );
  }
}
