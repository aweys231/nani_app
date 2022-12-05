// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, avoid_print, unnecessary_import, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput( {super.key, this.text, this.controller});
  final String? text;
  final TextEditingController? controller;
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
            TextField(
              onChanged: (value) {
                print(value);
              },
              obscureText: hidePassword,
              //show/hide password
              controller:widget.controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                
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
