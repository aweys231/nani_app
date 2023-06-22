// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    required this.press,
    this.SectionColor,
    this.SectionSize,
  }) : super(key: key);

  final String title;
  final Color? SectionColor;
  final GestureTapCallback press;
  final double? SectionSize;
  @override
  Widget build(BuildContext context) {
    return 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
              color: SectionColor, fontSize: SectionSize
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "See More",
            style: GoogleFonts.montserrat( color: SectionColor, fontSize: SectionSize),
          ),
        ),
      ],
    );
  }
}
