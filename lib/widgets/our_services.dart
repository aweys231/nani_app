// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nanirecruitment/size_config.dart';

class OurServices extends StatelessWidget {
  const OurServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(5)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Card(
                        shadowColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 8,
                        margin: EdgeInsets.all(5),
                        borderOnForeground: true,
                        child: Container(
                          padding:
                              EdgeInsets.all(getProportionateScreenWidth(5)),
                          width: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(110),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    width: getProportionateScreenWidth(100),
                                    height: getProportionateScreenHeight(60),
                                    child: Image.asset(
                                      'assets/servicesimage/shoopping.png',
                                      // fit: BoxFit.cover,
                                    ),
                                    //  CircleAvatar(
                                    //     backgroundImage: AssetImage(
                                    //   'assets/servicesimage/shoopping.png',
                                    // )),
                                  ),
                                ),
                                Text('Shopping')
                              ]),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Card(
                        shadowColor: Colors.red,
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        borderOnForeground: true,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(110),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    width: getProportionateScreenWidth(100),
                                    height: getProportionateScreenHeight(60),
                                    child: Image.asset(
                                      'assets/servicesimage/awaaaaa.png',
                                      // fit: BoxFit.cover,
                                    ),
                                    //  CircleAvatar(
                                    //     backgroundImage: AssetImage(
                                    //   'assets/servicesimage/awaaaaa.png',
                                    // )),
                                  ),
                                ),
                                Text('Restaurant')
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Card(
                        shadowColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        borderOnForeground: true,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(110),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    width: getProportionateScreenWidth(100),
                                    height: getProportionateScreenHeight(60),

                                    child: Image.asset(
                                      'assets/servicesimage/hotel.png',
                                      // fit: BoxFit.cover,
                                    ),
                                    //  CircleAvatar(
                                    //     backgroundImage: AssetImage(
                                    //   'assets/servicesimage/hotel.png',
                                    // )),
                                  ),
                                ),
                                Text('Hotel Booking')
                              ]),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Card(
                        shadowColor: Colors.red,
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        borderOnForeground: true,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: getProportionateScreenWidth(150),
                          height: getProportionateScreenHeight(110),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    width: getProportionateScreenWidth(100),
                                    height: getProportionateScreenHeight(60),

                                    child: Image.asset(
                                      'assets/servicesimage/travel.png',
                                      // fit: BoxFit.cover,
                                    ),
                                    // CircleAvatar(
                                    //     backgroundImage: AssetImage(
                                    //   'assets/servicesimage/travel.png',
                                    // )),
                                  ),
                                ),
                                Text('resevation')
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ])),
      // ),
    );
  }
}
