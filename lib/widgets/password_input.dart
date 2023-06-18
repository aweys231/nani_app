// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print, unnecessary_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    Key? key,
    this.text,
    this.controller,
    this.onChanged,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted, this.onValidate,
  } ): super(key: key);
  final String? text;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String val)? onValidate;
  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.text!,
                style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              onChanged: (v) => widget.onChanged!(v),
              validator: (v) => widget.onValidate!(v!),
              obscureText: hidePassword,
              //show/hide password
              controller: widget.controller,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              onSaved: (v) => widget.onSubmitted!(v!),

              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                // errorText:widget.validator,
                suffixIcon: IconButton(
                  icon: hidePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10), //circular border for TextField.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
