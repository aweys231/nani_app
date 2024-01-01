import 'package:flutter/material.dart';
import 'package:nanirecruitment/constants.dart';
class AppButton extends StatelessWidget {
  final double? fontSize;
  final IconData icon;
  final Function()? Ontap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final String text;

  const AppButton(
      {this.backgroundColor=bggprimary,
        required this.icon,
        this.fontSize=20,
        this.Ontap,
        this.iconColor=Colors.white,
        this.textColor = Colors.black,
        required this.text,
        Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: backgroundColor,
            ),
            child: Icon(
              icon,size: 30,color: iconColor,
            ),
          ),
          text!=null?Text(text!,style: TextStyle(
              fontSize: 14,
              color: textColor
          ),):Container(),

        ],
      ),
    );
  }
}
