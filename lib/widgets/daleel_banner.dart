// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DaleelBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
     Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical:15.0, horizontal: 15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextSpan(text: "Join Nani Recruitment Application\n"),
            TextSpan(
              text: "Job booking",
              style: TextStyle(
                fontSize: 20,
                // fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
