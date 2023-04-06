// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nanirecruitment/screens/availability.dart';
import 'package:nanirecruitment/screens/client_dhashboard.dart';

class BottomNavigationBars extends StatefulWidget {
  
const BottomNavigationBars(this.role_id, this.candidate_id, {super.key});
  final String? role_id;
  final String? candidate_id;
  @override
  State<BottomNavigationBars> createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          ClientDhashboard(widget.role_id, widget.candidate_id),
          Availability(widget.candidate_id),

        ],
      ),
      bottomNavigationBar:
       Container(
        height: 70,
        margin: EdgeInsets.only(left: 12, right: 12, top: 12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(FontAwesomeIcons.calendarDay, 
                         color: currentIndex==0? Theme.of(context).primaryColor: Theme.of(context).primaryColorLight,
                         size: currentIndex==0?30:26,
                         ),
                        currentIndex==0? Container(
                          height: 3,
                          width: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          
                         ) :SizedBox(),
                       ],
                     ),
           
                  ),
                ),
              )),
               Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(FontAwesomeIcons.calendarDay, 
                         color: currentIndex==1? Theme.of(context).primaryColor: Theme.of(context).primaryColorLight,
                         size: currentIndex==1?30:26,
                         ),
                        currentIndex==1? Container(
                          height: 3,
                          width: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          
                         ):SizedBox()
                       ],
                     ),
           
                  ),
                ),
              )),
              
               ],
          ),
        ),
      ),
    );
  }
}
