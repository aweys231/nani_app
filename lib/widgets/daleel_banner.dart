// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DaleelBanner extends StatelessWidget {
  const DaleelBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      // margin: EdgeInsets.all(getProportionateScreenWidth(15)),
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15.0), horizontal: getProportionateScreenWidth(15.0)),
      // padding: EdgeInsets.symmetric(
      //   horizontal: getProportionateScreenWidth(20),
      //   vertical: getProportionateScreenWidth(15),
      // ),
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
                fontSize: getProportionateScreenWidth(20),
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
