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
  final TextInputAction? textInputAction;

  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final IconButton? suffixIcon;
  final String? validator;

  const CustomInput({
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
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: TextField(
        onChanged: (v) => onChanged!(v),
        
        keyboardType: keyboardtype,
        maxLines: maxlines,
        maxLength: maxlength,
        controller: controller,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onSubmitted: (v) => onSubmitted!(v),
        
        decoration: InputDecoration(
        hintText: hint!,
        errorText:validator,
        labelText: label,
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
