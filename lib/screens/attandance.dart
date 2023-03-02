// ignore_for_file: prefer_const_constructors, unnecessary_import, implementation_imports, avoid_unnecessary_containers, unused_local_variable, empty_catches, unused_import, non_constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables, await_only_futures, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:nanirecruitment/providers/auth.dart';
import 'package:nanirecruitment/providers/jobs.dart';
import 'package:nanirecruitment/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CanidateAttandance extends StatefulWidget {
  static const routeName = '/candidate-attandance';
  const CanidateAttandance({this.candidate_id, this.jobvacancy_id, super.key});
  final String? candidate_id;
  final String? jobvacancy_id;

  @override
  State<CanidateAttandance> createState() => _CanidateAttandanceState();
}

class _CanidateAttandanceState extends State<CanidateAttandance> {
  double screenHeight = 0;
  double screenWidth = 0;
  String checkInt = '--/--';
  String checkOut = '--/--';
  var checkdat;
  var candidateid;
  void getRecode() async {
    try {
      checkdat = await Provider.of<Jobs_Section>(context, listen: false)
          .timeSheetChecking(widget.candidate_id.toString());
      print('object');
      // _showErrorDialog('hello');
      print(checkdat[0]['timein'].toString());
      if (checkdat[0]['timein'].toString() != ''  && checkdat[0]['timeout'] != '') {
        setState(() {
          checkInt = checkdat[0]['timein'].toString();
          checkOut = checkdat[0]['timeout'].toString();
        });
      } else if (checkdat[0]['timein'] != '' && checkdat[0]['timeout'] == '') {
        setState(() {
          checkInt = checkdat[0]['timein'].toString();
          checkOut = '--/--';
        });
      }
    
    } catch (e) {
      // setState(() {
      //   checkInt = '--/--';
      //   checkOut = '--/--';
      //   print(checkdat['timein'].toString());
      // });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    getRecode();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    candidateid = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Attandance'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20),
              child: Text(
                candidateid.candidate_id.toString(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth / 20,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              // margin: EdgeInsets.only(top: 32),
              child: Text(
                widget.jobvacancy_id.toString(),
                style: TextStyle(
                  color: Color.fromARGB(255, 227, 73, 73),
                  fontSize: screenWidth / 18,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child: Text(
                "To days Status",
                style: TextStyle(
                  fontSize: screenWidth / 18,
                  fontFamily: 'Lato',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 32),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Check In",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          checkInt,
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          "Check Out",
                          style: TextStyle(
                            fontSize: screenWidth / 20,
                            fontFamily: 'Lato',
                          ),
                        ),
                        Text(
                          checkOut,
                          style: TextStyle(
                              fontSize: screenWidth / 18,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                      text: DateTime.now().day.toString(),
                      style: TextStyle(color: Colors.purple),
                      children: [
                        TextSpan(
                          text: DateFormat(' MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: screenWidth / 20,
                              fontFamily: 'Lato',
                              color: Colors.black54),
                        )
                      ]),
                )),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('hh:mm:ss a').format(DateTime.now()),
                      style: TextStyle(
                          fontSize: screenWidth / 20,
                          fontFamily: 'Lato',
                          color: Colors.black54),
                    ),
                  );
                }),
            checkOut == '--/--'
                ? Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Builder(builder: (context) {
                      final GlobalKey<SlideActionState> key = GlobalKey();
                      return SlideAction(
                        text: checkInt == '--/--'
                            ? "Slide check In"
                            : "Slide check Out",
                        textStyle: TextStyle(
                            fontSize: screenWidth / 20,
                            fontFamily: 'Lato',
                            color: Colors.black54),
                        outerColor: Colors.white,
                        innerColor: Colors.purple,
                        key: key,
                        onSubmit: (() {
                          key.currentState!.reset();
                          getRecode();
                        }),
                      );
                    }),
                  )
                : Container(
                    child: Text('You have already check out'),
                  ),
          ],
        ),
      ),
    );
  }
}
