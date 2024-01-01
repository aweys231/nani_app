// ignore_for_file: avoid_web_libraries_in_flutter, unnecessary_import, unused_import, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nanirecruitment/constants.dart';

class mCustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  final int? maxlines;
  final int? maxlength;
  final Icon? icon;
  final TextInputAction? textInputAction;

  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final IconButton? suffixIcon;
  final String? Function(String val)? onValidate;

  const mCustomInput({
    Key? key,
    this.onChanged,
    this.hint,
    this.controller,
    this.label,
    this.keyboardtype,
    this.maxlines,
    this.maxlength,
    this.icon,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
    this.suffixIcon,
    this.onValidate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: TextFormField(
        onChanged: (v) => onChanged!(v),
        
        keyboardType: keyboardtype,
        maxLines: maxlines,
        maxLength: maxlength,
        controller: controller,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onSaved: (v) => onSubmitted!(v!),
        decoration: InputDecoration(
        hintText: hint!,
        // errorText:validator,
        labelText: label,
          labelStyle: TextStyle(
            color: txtcolor
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintStyle: TextStyle(
            color: txtcolor
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: icon,
          suffixIcon:suffixIcon,
          
        ),
      ),
    );
  }
}
